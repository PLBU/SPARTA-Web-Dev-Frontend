import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';

Future<bool> sendSupport(bool isAnonym, String penerima, String text, String jwt) async {
  final Map<String, String> body = {'penerima': penerima, 'text': text};
  final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'};
  final encoding = Encoding.getByName('utf-8');
  String jsonBody = json.encode(body);

  final response = await http.post(
    (isAnonym) ? NetworkUtil.getApiUrl(route: 'supports', urlParams: 'anonymous') : NetworkUtil.getApiUrl(route: 'supports'),
    body: jsonBody,
    headers: headers,
    encoding: encoding,
  );

  if (response.statusCode == 201) {
    return true;
  } else return false;
}
