import 'package:flutter/foundation.dart';

class NetworkUtil {
  static const String BASE_URI = 'spartabe.fly.dev';

  static Uri getApiUrl({
    @required String route,
    dynamic queryParams,
    String urlParams,
  }) {
    return Uri.https(
        BASE_URI,
        (urlParams != null) ? '/api/$route/$urlParams' : '/api/$route',
        queryParams);
  }
}
