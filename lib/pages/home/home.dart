import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_running_logo.dart';
import 'package:sparta/widgets/my_card.dart';

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
            MyCard(
              title: "Test",
              image: Image.asset('images/PatternSparta.png',width: 50,height: 50,),
              content: "SPARTA adalah lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.SPARTA adalah lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.SPARTA adalah lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              type: Type.Bottom,
            ),
            // MyTitle(text: "IKUZO", logo: "!!"),
            // SizedBox(height: 100),
            // SizedBox(height: 100),
            // MyTitle(text: "SPARTA", logo: "?"),
            // SizedBox(height: 100),
            // MyTitle(text: "Profile"),
          ],
        ),
      ),
    );
  }
}
