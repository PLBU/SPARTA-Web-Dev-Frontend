import 'package:flutter/material.dart';
import 'package:sparta/pages/home/views/landing.dart';
import 'package:sparta/widgets/my_pattern_decoration.dart';
import 'package:sparta/pages/home/views/info_sparta.dart';
import 'package:sparta/pages/home/views/info_hmif.dart';
import 'package:sparta/pages/home/views/info_panitia.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LandingView(),
          MyPatternDecoration(),
          SizedBox(height: 40),
          // INSERTT IMAGE HERE
          SizedBox(height: 40),
          InfoHMIF(),
          SizedBox(height: 40),
          InfoSparta(),
          SizedBox(height: 40),
          InfoPanitia(),
        ],
      ),
    );
  }
}
