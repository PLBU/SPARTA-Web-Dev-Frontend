import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyHeadingText extends StatelessWidget {
  const MyHeadingText({ this.content, this.color });

  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Text(
      this.content,
      style: TextStyle(
        color: this.color,
        fontFamily: 'DrukWideBold',
        fontSize:
          (deviceType == DeviceType.mobile) ? 24
          : (deviceType == DeviceType.tablet) ? 30
          : 36,
      ),
    );
  }
}