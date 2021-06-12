import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_running_logo.dart';
import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_text_list.dart';

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
                for (int i=0;i<5;i++) "John Doe (13519000)",
                ],
            )          
          ],
        ),
      ),
    );
  }
}
