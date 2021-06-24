import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';
import 'package:sparta/models/user.dart';

Future<User> fetchUser(var id) async{
    final uri = NetworkUtil.getApiUrl(urlParams: id.toString(), route: 'users');
    final response = await http.get(uri);
    User suppUser = User.fromJson(jsonDecode(response.body));

    return suppUser;
}

void main(List<User> args) async{
  await fetchUser('609e0e693ebbf233e1808cb3');
}