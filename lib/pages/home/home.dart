import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_running_logo.dart';
import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_text_list.dart';
import 'package:sparta/widgets/my_heading_text.dart';

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
            MyTextList(
              title: "DIVISI",
              list: [
                for (int i=0;i<50;i++) "John Doe (13519000)",
                ],
            )          
            // MyCard(
            //   title: "Test",
            //   image: Image.asset('images/PatternSparta.png',width: 50,height: 50,),
            //   content: "SPARTA adalah lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.SPARTA adalah lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.SPARTA adalah lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            //   type: CardType.Right,
            // ),
            // MyTitle(text: "IKUZO", logo: "!!"),
            // SizedBox(height: 100),
            // SizedBox(height: 100),
            // MyTitle(text: "SPARTA", logo: "?"),
            // SizedBox(height: 100),
            // MyTitle(text: "Profile"),
            MyHeadingText(content: 'FEATURED'),
          ],
        ),
      ),
    );
  }
}
