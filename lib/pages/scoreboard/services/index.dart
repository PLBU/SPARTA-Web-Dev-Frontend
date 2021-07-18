import 'dart:convert';
import 'dart:developer';
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

Future<bool> updateBulkScores(
  int newSkor,
  List<int> kelompok,
  List<String> nim,
  String jwt,
) async {
  final Map<String, dynamic> body = {
    'score': newSkor,
    'kelompok': kelompok,
    'nim': nim,
  };
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt'
  };
  final encoding = Encoding.getByName('utf-8');
  String jsonBody = json.encode(body);

  inspect(body);

  final response = await http.put(
    NetworkUtil.getApiUrl(
      route: 'users/update-score',
    ),
    body: jsonBody,
    headers: headers,
    encoding: encoding,
  );

  if (response.statusCode == 200) {
    return true;
  } else
    return false;
}
