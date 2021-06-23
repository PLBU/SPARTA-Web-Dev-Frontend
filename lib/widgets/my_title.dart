import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyTitle extends StatelessWidget {
  /// Custom Title that accepts [logo] and required [text]
  ///
  /// [logo] would be rendered to a spiky buble
  /// and [text] rendered right next to it
  MyTitle({this.logo, @required this.text});

  final String logo;
  final String text;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double leavesHeight = (deviceType == DeviceType.mobile)
        ? 40
        : (deviceType == DeviceType.tablet)
            ? 56
            : 80;

    double logoHeight = (deviceType == DeviceType.mobile)
        ? 28
        : (deviceType == DeviceType.tablet)
            ? 36
            : 50;

    double fontSize = (deviceType == DeviceType.mobile)
        ? 28
        : (deviceType == DeviceType.tablet)
            ? 36
            : 50;

    double space = (deviceType == DeviceType.tablet) ? 18 : 24;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logo != null)
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/icons/leaves.png",
                  height: leavesHeight,
                ),
                Text(
                  logo,
                  style: TextStyle(
                    fontFamily: 'DrukWideBold',
                    fontSize: logoHeight,
                  ),
                )
              ],
            ),
          if (logo != null) SizedBox(width: space),
          Text(
            text,
            style: TextStyle(fontFamily: 'DrukWideBold', fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
