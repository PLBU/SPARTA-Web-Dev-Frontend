import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sparta/models/user.dart';

Future<List<User>> fetchUsers(
    String jurusan, String nim, String name, String kelompok,
  ) async {
  final query = {
    "jurusan": jurusan,
    "nim": nim,
    "name": name,
    "kelompok": kelompok,
  };

  final uri = Uri.https('sparta-backend.herokuapp.com', '/api/users/', query);
  final response = await http.get(uri);
  // print(response.body);

  var list = jsonDecode(response.body) as List;
  List<User> listUsers = list.map((obj) => User.fromJson(obj)).toList();

  return listUsers;
}

void main(List<String> args) async {
  await fetchUsers(null, null, null, null);
}
