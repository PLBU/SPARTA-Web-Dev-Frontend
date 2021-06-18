import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.helperText,
    this.width,
    this.margin,
    this.controller,
    this.submitHandler,
    this.prefixIcon,
    this.suffixIcon,
    this.hidden = false,
  });

  final helperText;
  final prefixIcon;
  final suffixIcon;
  final controller;
  final submitHandler;
  final margin;
  final width;
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
      child: TextField(
        obscureText: this.hidden,
        controller: this.controller,
        cursorColor: Colors.black,
        minLines: this.minLines,
        maxLines: this.hidden ? 1 : this.maxLines,
        maxLength: this.maxLength,
        onSubmitted: this.submitHandler,
        decoration: InputDecoration(
          hintText: this.hintText,
          hintStyle: TextStyle(fontFamily: 'Roboto'),
          helperText: this.helperText,
          helperStyle: TextStyle(fontFamily: 'Roboto', fontSize: respText),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
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
