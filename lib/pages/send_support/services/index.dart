import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';

Future<bool> sendSupport(String penerima, String text, String jwt) async {
  final Map<String, String> body = {'penerima': penerima, 'text': text};
  final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'};
  final encoding = Encoding.getByName('utf-8');
  String jsonBody = json.encode(body);

  final response = await http.post(
    NetworkUtil.getApiUrl(route: 'supports'),
    body: jsonBody,
    headers: headers,
    encoding: encoding,
  );

  if (response.statusCode == 200) {
    return true;
  } else return false;
}
