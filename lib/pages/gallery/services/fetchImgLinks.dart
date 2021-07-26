import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sparta/utils/network_util.dart';

Future<List<List<String>>> fetchImgLinks() async{
    final uri = NetworkUtil.getApiUrl(route: 'gallery');
    final response = await http.get(uri);
    var list = jsonDecode(response.body) as List;
    List<List<String>> imgLinks = [];
    for (var i=0; i<9; i++){
      List<String> currLinks = list[i].cast<String>();
      imgLinks.add(currLinks);
    }

    return imgLinks;
}