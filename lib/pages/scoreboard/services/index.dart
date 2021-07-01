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

Future<List<User>> fetchTopThree(User user1, User user2, User user3) async {
  var response1 = await http.get(NetworkUtil.getApiUrl(
    route: 'users/custom', 
    queryParams: {"id": user1.id},
  ));
  var response2 = await http.get(NetworkUtil.getApiUrl(
    route: 'users/custom', 
    queryParams: {"id": user2.id},
  ));
  var response3 = await http.get(NetworkUtil.getApiUrl(
    route: 'users/custom', 
    queryParams: {"id": user3.id},
  ));

  if (response1.statusCode == 200 
    && response2.statusCode == 200 
    && response3.statusCode == 200 ){

    return [
      User.fromJson({
        'id': user1.id,
        'namaLengkap': user1.namaLengkap,
        'nim': user1.nim,
        'skor': user1.skor,
        'foto': jsonDecode(response1.body)['foto'],
      }),
      User.fromJson({
        'id': user2.id,
        'namaLengkap': user2.namaLengkap,
        'nim': user2.nim,
        'skor': user2.skor,
        'foto': jsonDecode(response2.body)['foto'],
      }),
      User.fromJson({
        'id': user3.id,
        'namaLengkap': user3.namaLengkap,
        'nim': user3.nim,
        'skor': user3.skor,
        'foto': jsonDecode(response3.body)['foto'],
      }),
    ];
  }
  return null;
}

void main(List<String> args) async {
  await fetchUsers(null, null, null, null);
}
