import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

/// Utility Class for UI Widgets
class UIUtils {
  /// Get the [DeviceType] { mobile, tablet, desktop } by taking the current [BuildContext]
  static DeviceType getDeviceType(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return size.width < 480
        ? DeviceType.mobile
        : size.width < 1200
            ? DeviceType.tablet
            : DeviceType.desktop;
  }

  /// Get the [Orientation] device by taking the current [BuildContext]
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
