import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyHeadingText extends StatelessWidget {
  const MyHeadingText({ this.content });

  final String content;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);


    return Text(
      this.content,
      style: TextStyle(
        fontFamily: 'DrukWideBold',
        fontSize:
          (deviceType == DeviceType.mobile) ? 18
          : (deviceType == DeviceType.tablet) ? 25
          : 40,
      ),
    );
  }
}