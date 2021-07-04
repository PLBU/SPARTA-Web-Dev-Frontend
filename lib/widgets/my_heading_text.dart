import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyHeadingText extends StatelessWidget {
  const MyHeadingText({this.content, this.textAlign = TextAlign.center});

  final String content;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Text(
      this.content,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'DrukWideBold',
        fontSize: (deviceType == DeviceType.mobile)
            ? 20
            : (deviceType == DeviceType.tablet)
                ? 30
                : 36,
      ),
      textAlign: textAlign,
    );
  }
}
