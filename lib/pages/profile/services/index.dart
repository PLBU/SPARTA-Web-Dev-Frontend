import 'dart:convert';
import 'package:sparta/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';

Future<User> fetchOneUser(String id) async {
  final response = await http.get(NetworkUtil.getApiUrl(route: 'users', urlParams: id));

  if (response.statusCode == 200) {
    final user = User.fromJson(jsonDecode(response.body));
    return user;
  } else {
    return null;
  }
}