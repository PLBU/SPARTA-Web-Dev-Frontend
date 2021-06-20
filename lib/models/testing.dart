// import 'package:sparta/models/assignment.dart';
// import 'package:sparta/models/submission.dart';
// import 'package:sparta/utils/network_util.dart';
// import 'package:sparta/models/support.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:developer';

// void runTesto() async {
//   // testing
//   final response = await http.get(
//        NetworkUtil.getApiUrl(
//         route: 'submissions'
//       ),
//       headers: {
//         "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJlbmFsZGlAYXJsaW4uY29tIiwiaWQiOiI2MGJhZTlmMmRkZjlkNzI3ZGFmZDZmYTciLCJuaW0iOiIxNjUxOTE5OSIsImlhdCI6MTYyNDEyMDM5NSwiZXhwIjoxNjI0MTIzOTk1fQ.AEJd3ahUt-v0gHeYNg7HOebt3PP66uIRLniRshYtAxE",
//       });
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     var list = jsonDecode(response.body) as List;
//     print(response.body);
//     print(list);
//     print("WOY ANJING");
//     for (var obj in list) {
//       print("ini yg gk bisa?");
//       inspect(Submission.fromJson(obj));
//     }

//     // return User.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Mai tiaoo fai kiao');
//   }
// }
