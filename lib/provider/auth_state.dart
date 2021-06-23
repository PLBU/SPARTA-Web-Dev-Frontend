import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';
import 'package:sparta/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  static SharedPreferences storage;
  static StateProvider<dynamic> jwt = StateProvider((ref) => null);
  static StateProvider<dynamic> currentUser = StateProvider((ref) => null);

  static Future<void> init() async {
    storage = await SharedPreferences.getInstance();

    if (storage.containsKey('jwt') && storage.containsKey('currentUser')) {
      String savedJwt = storage.getString('jwt');
      User savedUser =
          User.fromJson(json.decode(storage.getString('currentUser')));

      jwt = StateProvider((ref) => savedJwt);
      currentUser = StateProvider((ref) => savedUser);
    }
  }

  static Future<void> login(String email, String password, BuildContext context) async {
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
        encoding: encoding);

    var responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      context.read(jwt).state = responseBody['token'];
      context.read(currentUser).state = User.fromJson(responseBody['user']);
      storage.setString('jwt', responseBody['token']);
      storage.setString('currentUser', json.encode(responseBody['user']));
    } else {
      throw Exception(responseBody['error']);
    }
  }

  static void logout(BuildContext context) {
    Navigator.pushNamed(context, '/');
    context.read(jwt).state = null;
    context.read(currentUser).state = null;

    storage.remove('jwt');
    storage.remove('currentUser');
  }
}
