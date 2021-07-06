import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';
import 'package:sparta/models/user.dart';

Future<List<User>> fetchUsers(
  String jurusan,
  String nim,
  String name,
  String kelompok,
) async {
  final query = {
    "jurusan": jurusan,
    "nim": nim,
    "name": name,
    "kelompok": kelompok,
  };

  final uri = NetworkUtil.getApiUrl(route: 'users', queryParams: query);
  final response = await http.get(uri);

  var list = jsonDecode(response.body) as List;
  List<User> listUsers = list.map((obj) => User.fromJson(obj)).toList();

  return listUsers;
}