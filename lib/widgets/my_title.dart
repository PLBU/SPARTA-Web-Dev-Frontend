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
                  height: (deviceType == DeviceType.mobile)
                      ? 32
                      : (deviceType == DeviceType.tablet)
                          ? 48
                          : 80,
                ),
                Text(
                  logo,
                  style: TextStyle(
                    fontFamily: 'DrukWideBold',
                    fontSize: (deviceType == DeviceType.mobile)
                        ? 20
                        : (deviceType == DeviceType.tablet)
                            ? 30
                            : 50,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          if (logo != null) SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'DrukWideBold',
              fontSize: (deviceType == DeviceType.mobile)
                  ? 20
                  : (deviceType == DeviceType.tablet)
                      ? 30
                      : 50,
            ),
          ),
        ],
      ),
    );
  }
}
