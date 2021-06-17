import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/widgets/my_button.dart';

void showMySupportDialog(BuildContext context, String nickname) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          actionsPadding: EdgeInsets.only(bottom: 24, right: 12),
          title: Text(
            'Send support to ' + nickname,
            style: TextStyle(fontFamily: 'DrukWideBold'),
          ),
          content: Container(
            width: 360,
            child: TextField(
              cursorColor: Colors.black,
              minLines: 8,
              maxLines: null,
              maxLength: 300,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'Roboto'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusColor: Colors.black,
                  hintText: 'Type your support message here!!'),
            ),
          ),
          actions: <Widget>[
            MyButton(
              handler: () {
                Navigator.of(context).pop();
              },
              text: "Send Support",
              buttonType: ButtonType.white,
            ),
          ],
        );
      });
}
