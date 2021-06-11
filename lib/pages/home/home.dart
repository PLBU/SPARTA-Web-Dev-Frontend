import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_running_logo.dart';
import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_footer.dart';

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
            MyFooter(),
            ],
        ),
      ),
    );
  }
}
