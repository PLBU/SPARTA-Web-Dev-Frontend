import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sparta/models/support.dart';
import 'package:sparta/utils/network_util.dart';

Future<List<Support>> fetchSupports(String id, String jwt, bool isPengirim) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt'
  };
  final uri = NetworkUtil.getApiUrl(
    route: 'supports',
    queryParams: {
      if (isPengirim) 'pengirim': id,
      if (!isPengirim) 'penerima': id
    },
  );
  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var list = jsonDecode(response.body) as List;
    return list.map((obj) => Support.fromJson(obj)).toList();
  } else {
    return null;
  }
}
