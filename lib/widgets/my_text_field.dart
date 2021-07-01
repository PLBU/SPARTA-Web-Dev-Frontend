import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    this.minLines = 1,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.helperText,
    this.labelText,
    this.width,
    this.height,
    this.margin,
    this.controller,
    this.submitHandler,
    this.prefixIcon,
    this.suffixIcon,
    this.hidden = false,
  });

  final helperText;
  final labelText;
  final prefixIcon;
  final suffixIcon;
  final controller;
  final submitHandler;
  final margin;
  final width;
  final height;
  final minLines;
  final maxLines;
  final maxLength;
  final hintText;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double respText = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 12
            : 16;

    return Container(
      margin: this.margin,
      width: this.width,
      height: (minLines > 1)
          ? null
          : (deviceType == DeviceType.mobile)
              ? 60
              : 80,
      child: TextField(
        obscureText: this.hidden,
        controller: this.controller,
        cursorColor: Colors.black,
        minLines: this.minLines,
        maxLines: this.hidden ? 1 : this.maxLines,
        maxLength: this.maxLength,
        onSubmitted: this.submitHandler,
        style: TextStyle(
          fontSize: respText,
        ),
        decoration: InputDecoration(
          labelText: this.labelText,
          hintText: this.hintText,
          hintStyle: TextStyle(fontFamily: 'Roboto'),
          helperText: this.helperText,
          helperStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: respText,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          focusColor: Colors.black,
          prefixIcon: this.prefixIcon,
          suffixIcon: this.suffixIcon,
        ),
      ),
    );
  }
}
