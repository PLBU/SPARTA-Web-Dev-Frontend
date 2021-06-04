import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyRunningLogo extends StatelessWidget {
  const MyRunningLogo();

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double size = deviceType == DeviceType.mobile ? 30 : 50;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      color: Colors.black,
      child: Image.asset(
        'images/PatternSparta.png',
        height: size,
        width: size,
        repeat: ImageRepeat.repeatX,
      ),
    );
  }
}