import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyPatternDecoration extends StatelessWidget {
  const MyPatternDecoration({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double size = deviceType == DeviceType.mobile
        ? 24
        : deviceType == DeviceType.tablet
            ? 32
            : 40;

    return Container(
      width: double.infinity,
      padding: deviceType == DeviceType.mobile
          ? const EdgeInsets.only(top: 1, bottom: 1)
          : const EdgeInsets.only(top: 5, bottom: 5),
      color: Colors.black,
      child: Image.asset(
        'assets/icons/pattern_sparta.png',
        height: size,
        width: size,
        repeat: ImageRepeat.repeatX,
      ),
    );
  }
}
