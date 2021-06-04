import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyRunningLogo extends StatelessWidget {
  const MyRunningLogo();

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double size = deviceType == DeviceType.mobile ? 10 : deviceType == DeviceType.tablet? 20 : 40;

    return Container(
      width: double.infinity,
      padding: 
        deviceType == DeviceType.mobile ? 
        const EdgeInsets.only(top: 1, bottom: 1) : 
        const EdgeInsets.only(top: 5, bottom: 5),
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