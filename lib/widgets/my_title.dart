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

    double spikyBubbleHeight = (deviceType == DeviceType.mobile)
        ? 42
        : (deviceType == DeviceType.tablet)
            ? 56
            : 80;

    double fontSize = (deviceType == DeviceType.mobile)
        ? 24
        : (deviceType == DeviceType.tablet)
            ? 32
            : 50;

    double space = (deviceType == DeviceType.mobile)
        ? 8
        : (deviceType == DeviceType.tablet)
            ? 18
            : 24;

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
                  "assets/icons/spiky_bubble.png",
                  height: spikyBubbleHeight,
                ),
                Text(
                  logo,
                  style: TextStyle(
                    fontFamily: 'DrukWideBold',
                    fontSize: fontSize,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          if (logo != null) SizedBox(width: space),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'DrukWideBold',
              fontSize: fontSize,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
