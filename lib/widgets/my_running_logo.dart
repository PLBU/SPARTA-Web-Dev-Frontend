import 'package:flutter/material.dart';

class MyRunningLogo extends StatelessWidget {
  const MyRunningLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Image.asset(
        'images/PatternSparta.png',
        height: 80,
        width: 80,
        repeat: ImageRepeat.repeatX,
      ),
    );
  }
}