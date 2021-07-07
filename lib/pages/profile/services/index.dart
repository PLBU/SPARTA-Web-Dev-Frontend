import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sparta/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';

Future<User> fetchOneUser(String id) async {
  final response =
      await http.get(NetworkUtil.getApiUrl(route: 'users', urlParams: id));

  if (response.statusCode == 200) {
    final user = User.fromJson(jsonDecode(response.body));
    return user;
  } else {
    return null;
  }
}

Future<bool> updateSkorOneUser(int newSkor, String userId, String jwt) async {
  final Map<String, dynamic> body = {'skor': newSkor};
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt'
  };
  final encoding = Encoding.getByName('utf-8');
  String jsonBody = json.encode(body);

  final response = await http.put(
    NetworkUtil.getApiUrl(
      route: 'users',
      urlParams: userId,
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

Future<bool> postProfilePic(
  String jwt,
  List<int> newImageBytes,
) async {
  final String url =
      'https://sparta-backend.herokuapp.com/api/submissions/profile';
  final dio = Dio();

  var formData = FormData.fromMap({
    if (newImageBytes != null)
      'file': MultipartFile.fromBytes(newImageBytes, filename: 'foto'),
  });

  try {
    var response = await dio.post(
      url,
      data: formData,
      options: Options(headers: {
        'Authorization': 'Bearer $jwt',
      }),
    );

    if (response.statusCode == 200)
      return true;
    else
      return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> updateProfilePic(
  String jwt,
  List<int> newImageBytes,
) async {
  if (newImageBytes == null) return true;

  final String url =
      'https://sparta-backend.herokuapp.com/api/submissions/profile';
  final dio = Dio();

  var formData = FormData.fromMap({
    if (newImageBytes != null)
      'file': MultipartFile.fromBytes(newImageBytes, filename: 'foto'),
  });

  try {
    var response = await dio.put(
      url,
      data: formData,
      options: Options(headers: {
        'Authorization': 'Bearer $jwt',
      }),
    );

    if (response.statusCode == 200)
      return true;
    else
      return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> updateOneUser(
  String userId,
  String jwt, {
  String newEmail,
  String newNamaLengkap,
  String newNamaPanggilan,
  String newPassword,
  String newInstagram,
}) async {
  final Map<String, dynamic> body = {
    'email': newEmail,
    'namaLengkap': newNamaLengkap,
    'namaPanggilan': newNamaPanggilan,
    'instagram': newInstagram,
    if (newPassword != '') 'password': newPassword,
  };
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt'
  };
  final encoding = Encoding.getByName('utf-8');
  String jsonBody = json.encode(body);

  final response = await http.put(
    NetworkUtil.getApiUrl(
      route: 'users',
      urlParams: userId,
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
