import 'dart:convert';
import 'package:dio/dio.dart';
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
    return null;
  }
}

Future<List<Submission>> fetchSubmissions(String token) async {
  final headers = {
    'Authorization': 'Bearer $token',
  };
  final uri = NetworkUtil.getApiUrl(
    route: 'submissions',
  );
  final response = await http.get(uri, headers: headers);

  if (response.statusCode != 400) {
    var list = jsonDecode(response.body) as List;
    List<Submission> submissions =
        list.map((obj) => Submission.fromJson(obj)).toList();

    return submissions;
  } else {
    return null;
  }
}

Future<List<dynamic>> fetchLists(String currentJWT) async {
  List<Assignment> assignments = await fetchAssignments(currentJWT);
  List<Submission> submissions = await fetchSubmissions(currentJWT);
  List<Assignment> unfinished = assignments
      .where(
        (assignment) =>
            submissions
                .where((submission) => submission.assignment == assignment.id)
                .length ==
            0,
      )
      .toList();

  return [
    assignments,
    submissions,
    unfinished,
  ].toList();
}

Future<int> postSubmission(
  List<int> data,
  String name,
  String token,
  String assignmentID,
) async {
  var formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
      data,
      filename: name,
    ),
    'assignment': assignmentID,
  });

  const String URL = 'https://sparta-backend.herokuapp.com/api/submissions';

  var dio = Dio();

  try {
    var response = await dio.post(
      URL,
      data: formData,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
    return response.statusCode;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<int> updateSubmission(
  List<int> data,
  String name,
  String token,
  String submissionID,
) async {
  var formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
      data,
      filename: name,
    )
  });

  final String url = 'https://sparta-backend.herokuapp.com/api/submissions/$submissionID';

  var dio = Dio();

  try {
    var response = await dio.put(
      url,
      data: formData,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
    print(response.data);

    return response.statusCode;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<int> createAssignment(dynamic data, String token) async {
  // { name, spek, deadline, kelompok, lowerScore, upperScore, nim }
  final Map<String, dynamic> body = {
    'name': data['name'],
    'spek': data['spek'],
    'deadline': data['deadline'],
    'kelompok': data['kelompok'],
    'lowerScore': data['lowerScore'],
    'upperScore': data['upperScore'],
    'nim': data['nim'],
  };
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final encoding = Encoding.getByName('utf-8');
  String jsonBody = json.encode(body);

  final response = await http.post(
    NetworkUtil.getApiUrl(route: 'assignments'),
    body: jsonBody,
    headers: headers,
    encoding: encoding,
  );

  return response.statusCode;
}
