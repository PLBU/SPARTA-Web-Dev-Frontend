import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyButton(
            handler: () {
              showMySupportDialog(context, "Manray");
            },
            text: "Support",
            buttonType: ButtonType.black,
          ),
          MyButton(
            handler: () {},
            text: "Next Page",
            buttonType: ButtonType.white,
          ),
        ],
      ),
    );
  }
}
