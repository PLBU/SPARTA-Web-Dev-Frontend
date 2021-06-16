import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTitle(text: "IKUZO", logo: "!!"),
            SizedBox(height: 100),
            MyTitle(text: "SPARTA", logo: "?"),
            SizedBox(height: 100),
            MyTitle(text: "Profile"),
          ],
        ),
      ),
    );
  }
}
