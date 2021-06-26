import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';

Future<List<String>> fetchFeatured() async{
    final uri = NetworkUtil.getApiUrl(route: 'gallery', urlParams: 'featured');
    final response = await http.get(uri);
    var list = jsonDecode(response.body) as List;
    List<String> imgLinks = list.cast<String>();

    return imgLinks;
}

void main(List<String> args) async{
  await fetchFeatured();
}