import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

enum ButtonType {
  white,
  black,
}

class MyButton extends StatelessWidget {
  final Function handler;
  final String text;
  final ButtonType buttonType;
  final isLoading;

  const MyButton(
      {this.handler, this.text, this.buttonType, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Color color =
        (buttonType == ButtonType.black) ? Colors.black : Colors.white;
    Color textColor =
        (buttonType == ButtonType.black) ? Colors.white : Colors.black;
    Color overlayColor =
        (buttonType == ButtonType.black) ? Colors.grey[850] : Colors.grey[200];
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double fontSize = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 13
            : 15;
    double paddingVertical = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 16
            : 18;
    double paddingHorizontal = (deviceType == DeviceType.mobile)
        ? 14
        : (deviceType == DeviceType.tablet)
            ? 20
            : 24;

    return Container(
      child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                  vertical: paddingVertical, horizontal: paddingHorizontal),
            ),
            overlayColor: MaterialStateProperty.all<Color>(overlayColor),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
          onPressed: this.handler,
          child: AnimatedSwitcher(
            key: ValueKey<bool>(isLoading),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            duration: const Duration(seconds: 1),
            child: (this.isLoading)
                ? SizedBox(
                  width: 1.5*fontSize,
                  height: 1.5*fontSize,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      strokeWidth: 2,
                    ),
                )
                : Text(
                    text,
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'DrukWideBold',
                        fontSize: fontSize),
                  ),
          )),
    );
  }
}
