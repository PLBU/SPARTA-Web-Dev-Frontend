import 'package:flutter/material.dart';
import './views/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Login(),
    );
  }
}
