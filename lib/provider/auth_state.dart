import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sparta/pages/profile/services/index.dart';
import 'package:sparta/utils/network_util.dart';
import 'package:sparta/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  static SharedPreferences storage;
  static StateProvider<dynamic> jwt = StateProvider((ref) => null);
  static StateProvider<dynamic> currentUser = StateProvider((ref) => null);
  static StateProvider<dynamic> type = StateProvider((ref) => null);

  static Future<void> init() async {
    storage = await SharedPreferences.getInstance();

    if (storage.containsKey('jwt') &&
        (storage.containsKey('currentUser') || storage.containsKey('type'))) {
      String savedJwt = storage.getString('jwt');

      if (JwtDecoder.isExpired(savedJwt)) {
        storage.remove('jwt');
        storage.remove('currentUser');
        storage.remove('type');
      } else {
        jwt = StateProvider((ref) => savedJwt);

        String savedType = storage.getString('type');
        type = StateProvider((ref) => savedType);

        if (savedType != 'admin') {
          User savedUser =
              User.fromJson(json.decode(storage.getString('currentUser')));
          currentUser = StateProvider((ref) => savedUser);
        }
      }
    }
  }

  static Future<void> updateUser(BuildContext context) async {
    final currUser = context.read(currentUser).state;
    if (currUser != null) {
      User updatedUser = await fetchOneUser(currUser.id);
      context.read(currentUser).state = updatedUser;
      storage.setString('currentUser', updatedUser.toString());
    }
  }

  static Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    final Map<String, String> body = {'email': email, 'password': password};
    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');
    String jsonBody = json.encode(body);

    final response = await http.post(
      NetworkUtil.getApiUrl(
        route: 'login',
      ),
      body: jsonBody,
      headers: headers,
      encoding: encoding,
    );

    var responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      User user = (responseBody['user'] != null) ? User.fromJson(responseBody['user']) : null;

      context.read(jwt).state = responseBody['token'];
      storage.setString('jwt', responseBody['token']);

      context.read(type).state = responseBody['type'];
      storage.setString('type', responseBody['type']);

      if (responseBody['type'] != 'admin') {
        context.read(currentUser).state = user;
        storage.setString('currentUser', json.encode(responseBody['user']));

        if (user.picture == null)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Sorry for the inconvenience, we refactored our Profile Picture code for better performance, please kindly upload again your picture that contains your face.'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Okay',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
              duration: Duration(seconds: 20),
            ),
          );
      }
    } else {
      throw Exception(responseBody['error']);
    }
  }

  static void logout(BuildContext context) {
    Navigator.pushNamed(context, '/');
    context.read(jwt).state = null;
    context.read(currentUser).state = null;
    context.read(type).state = null;

    storage.remove('jwt');
    storage.remove('currentUser');
    storage.remove('type');
  }

  static bool checkExpirationToken(BuildContext context) {
    String currentJwt = context.read(jwt).state;

    if (currentJwt != null) {
      if (JwtDecoder.isExpired(currentJwt)) {
        logout(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Your session has expired. Please kindly login again!'),
            behavior: SnackBarBehavior.floating,
          ),
        );

        return true;
      }
    }

    return false;
  }
}
