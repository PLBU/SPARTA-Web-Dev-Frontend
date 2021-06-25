import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/pages/support/views/support_builder.dart';

class SupportPage extends StatelessWidget {
  const SupportPage();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final currentUser = watch(AuthState.currentUser).state;
      final jwt = watch(AuthState.jwt).state;

      return SupportBuilder(user: currentUser, jwt: jwt);
    });
  }
}
