import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';
import 'package:sparta/models/assignment.dart';
import 'package:sparta/models/submission.dart';

Future<List<Assignment>> fetchAssignments(String token) async {
  final headers = {
    'Authorization': 'Bearer $token',
  };
  final uri = NetworkUtil.getApiUrl(
    route: 'assignments',
  );
  final response = await http.get(uri, headers: headers);

  if (response.statusCode != 400) {
    var list = jsonDecode(response.body) as List;
    List<Assignment> assignments =
        list.map((obj) => Assignment.fromJson(obj)).toList();

    return assignments;
  } else {
    inspect(response);
    return null;
  }
}
