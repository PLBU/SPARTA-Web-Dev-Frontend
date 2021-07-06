import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sparta/models/support.dart';
import 'package:sparta/utils/network_util.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/support/views/support_card.dart';

Future<List<Support>> fetchSupports(
    String id, String jwt, bool isPengirim) async {
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

Future<User> fetchUser(var id) async {
  if (id != null) {
    final uri = NetworkUtil.getApiUrl(
      route: 'users',
      urlParams: id,
    );
    final response = await http.get(uri);

    inspect(response);
    if (response.statusCode == 200) {
      User suppUser = User.fromJson(jsonDecode(response.body));

      return suppUser;
    }
  }

  return null;
}

Future<List<dynamic>> fetchLists(String id, String jwt, bool isPengirim) async {
  var supports = await fetchSupports(id, jwt, isPengirim);

  if (supports == null) return null;

  List<dynamic> resArr = [];
  for (var supp in supports) {
    User user = await fetchUser(isPengirim ? supp.penerima : supp.pengirim);

    resArr.add(SupportCard(
      suppInfo: supp.text,
      isPengirim: isPengirim,
      user: user,
    ));
  }

  return resArr;
}
