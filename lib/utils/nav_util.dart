import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/provider/auth_state.dart';

class NavUtil {
  static void navigate(BuildContext context, String routeName) {
    AuthState.checkExpirationToken(context);
    Navigator.pushNamed(context, routeName);
  }
}
