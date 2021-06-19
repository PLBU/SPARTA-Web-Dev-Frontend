import 'package:flutter/material.dart';
import 'package:sparta/pages/home/views/departemen.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_drawer.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_pattern_decoration.dart';
import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_text_list.dart';
import 'package:sparta/widgets/my_heading_text.dart';
import 'package:sparta/widgets/my_support_dialog.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/pages/home/views/info_sparta.dart';
import 'package:sparta/pages/home/views/info_hmif.dart';
import 'package:sparta/pages/home/views/divisi.dart';
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
          SizedBox(height: 20),
          MyPatternDecoration(),
          SizedBox(height: 40),
          // INSERTT IMAGE HERE
          SizedBox(height: 40),
          InfoSparta(),
          SizedBox(height: 40),
          InfoHMIF(),
          SizedBox(height: 40),
          InfoPanitia(),
        ],
      ),
    );
  }
}
