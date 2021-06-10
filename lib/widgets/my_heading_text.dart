import 'package:flutter/material.dart';

class MyHeadingText extends StatelessWidget {
  const MyHeadingText({ this.content });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.content,
      style: TextStyle(
        fontFamily: 'DrukWideBold',
        fontSize: 40,
      ),
    );
  }
}