import 'package:flutter/widgets.dart';

class RouteState {
  static final ValueNotifier<String> current = ValueNotifier<String>("/");
  
  static void changeRouteState(String routeName) {
    current.value = routeName;
  }
}