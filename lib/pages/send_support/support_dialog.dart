import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/pages/send_support/services/index.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/utils/ui_utils.dart';

void showSupportDialog(BuildContext context, String nickname, String userId) {
  final jwt = context.read(AuthState.jwt).state;

  if (jwt != null)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SupportDialog(userId: userId, jwt: jwt, nickname: nickname);
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

class SupportDialog extends StatefulWidget {
  const SupportDialog({
    Key key,
    @required this.userId,
    @required this.jwt,
    @required this.nickname,
  }) : super(key: key);

  final String userId;
  final String jwt;
  final String nickname;

  @override
  _SupportDialogState createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  bool _isAnonym = false;
  bool _isLoading = false;
  TextEditingController contentTEC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;

    Function handleOnClick = () async {
      setState(() {
        _isLoading = true;
      });
      final bool success = await sendSupport(_isAnonym, widget.userId, contentTEC.text, widget.jwt);
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
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    };

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      actionsPadding: EdgeInsets.only(bottom: 24, right: 12),
      title: Text(
        'Send support to ' + widget.nickname,
        style: TextStyle(fontFamily: 'DrukWideBold'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
            width: 360,
            controller: contentTEC,
            minLines: 8,
            maxLines: 8,
            maxLength: 300,
            hintText: 'Type your support message here!',
          ),
          Row(
            children: [
              SizedBox(width: (deviceType == DeviceType.mobile) ? 0 : 8,),
              Checkbox(
                activeColor: Colors.black,
                checkColor: Colors.white,
                value: _isAnonym,
                onChanged: (value){
                  setState(() {
                    _isAnonym = value;
                  });
                },),
              SizedBox(width: space/4,),
              Text("Send as anonymous"),
            ],
          ),
      ],),
      actions: <Widget>[
        MyButton(
          isLoading: _isLoading,
          handler: handleOnClick,
          text: "Send Support",
          buttonType: ButtonType.white,
        ),
      ],
    );
  }
}
