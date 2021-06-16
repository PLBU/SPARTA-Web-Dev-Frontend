class RouteState {
  static String current = "/";
  
  static void changeRouteState(String routeName) {
    current = routeName;
  }
}