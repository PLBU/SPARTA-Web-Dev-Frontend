import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/pages/send_support/services/index.dart';
import 'package:sparta/widgets/my_text_field.dart';

void showSupportDialog(BuildContext context, String nickname, String userId) {
  TextEditingController contentTEC = new TextEditingController();
  final jwt = context.read(AuthState.jwt).state;

  if (jwt != null)
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
          content: MyTextField(
            width: 360,
            controller: contentTEC,
            minLines: 8,
            maxLines: null,
            maxLength: 300,
            hintText: 'Type your support message here!',
          ),
          actions: <Widget>[
            MyButton(
              handler: () async {
                Navigator.of(context).pop();
                final success = await sendSupport(userId, contentTEC.text, jwt);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      (success)
                          ? 'Support was sent successfully!'
                          : 'There was an error when sending your support',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              text: "Send Support",
              buttonType: ButtonType.white,
            ),
          ],
        );
      },
    );
  else
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You must be logged in to support!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
}
