import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

enum ButtonType {
  white,
  black,
}

class MyButton extends StatefulWidget {
  final Function handler;
  final String text;
  final ButtonType buttonType;
  final isLoading;

  const MyButton(
      {this.handler, this.text, this.buttonType, this.isLoading = false});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color color =
        (widget.buttonType == ButtonType.black) ? Colors.black : Colors.white;
    Color textColor =
        (widget.buttonType == ButtonType.black) ? Colors.white : Colors.black;
    Color overlayColor = 
        (widget.buttonType == ButtonType.black) ? Colors.black : Colors.white;
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double fontSize = (deviceType == DeviceType.mobile)
        ? 9
        : (deviceType == DeviceType.tablet)
            ? 12.5
            : 14;
    double paddingVertical = (deviceType == DeviceType.mobile)
        ? 6
        : (deviceType == DeviceType.tablet)
            ? 16
            : 18;
    double paddingHorizontal = (deviceType == DeviceType.mobile)
        ? 12
        : (deviceType == DeviceType.tablet)
            ? 20
            : 24;

    double borderRadius = (deviceType == DeviceType.mobile) ? 10 : 12;

    return MouseRegion(
      onEnter: (PointerEvent details) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (PointerEvent details) {
        setState(() {
          _isHovered = false;
        });
      },
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>((_isHovered) ? 1 : 0),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                  vertical: paddingVertical, horizontal: paddingHorizontal),
            ),
            overlayColor: MaterialStateProperty.all<Color>(overlayColor),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
          onPressed: this.widget.handler,
          child: AnimatedSwitcher(
            key: ValueKey<bool>(widget.isLoading),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            duration: const Duration(seconds: 1),
            child: (this.widget.isLoading)
                ? SizedBox(
                    width: 1.5 * fontSize,
                    height: 1.5 * fontSize,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'DrukWideBold',
                      fontSize: fontSize,
                    ),
                  ),
          )),
    );
  }
}
