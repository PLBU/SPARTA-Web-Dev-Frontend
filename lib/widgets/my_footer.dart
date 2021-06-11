import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyFooter extends StatelessWidget {
  String text = "© SPARTA 2020";

  @override
  Widget build(BuildContext context) {
    ////// Style
    //// Footer box
    double footerHeight = MediaQuery.of(context).size.height/10;
    Color footerColor = Colors.black;

    //// Font
    Color fontColor = Colors.white;
    double fontSize = footerHeight/5;
    String fontFamily = 'Roboto';

    // Build implementation
    return Container(
      // Size
      height: footerHeight,
      width: double.infinity,

      // Color
      decoration: BoxDecoration(
        color: footerColor,
      ),

      //
      alignment: Alignment.center,

      // Text
      child: Text(
        text,
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
          ),
        ),
      
    );
  }

}