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
    double space = 40;

    return Column(
      children: [
        LandingView(),
        MyPatternDecoration(),
        SizedBox(height: 2 * space),
        InfoHMIF(),
        SizedBox(height: space),
        InfoSparta(),
        SizedBox(height: space),
        InfoPanitia(),
      ],
    );
  }
}
