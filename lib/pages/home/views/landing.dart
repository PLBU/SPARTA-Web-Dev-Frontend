import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double landingViewHeight = MediaQuery.of(context).size.height -
        MyNavigationBar().preferredSize.height;
    double landingViewWidth = MediaQuery.of(context).size.width;

    double lsRightBigArtWidth =
        (1 / 4 * landingViewWidth > 384) ? 384 : 1 / 4 * landingViewWidth;
    double lsLeftBigArtWidth =
        (1 / 4 * landingViewWidth > 401) ? 401 : 1 / 4 * landingViewWidth + 16;
    double lsRightSmallArtWidth =
        (1 / 6 * landingViewWidth > 267) ? 267 : 1 / 6 * landingViewWidth;
    double lsLeftSmallArtWidth =
        (1 / 6 * landingViewWidth > 221) ? 221 : 1 / 6 * landingViewWidth;
    double welcomeSpartaWidth = (deviceType == DeviceType.mobile)
        ? 0.85 * landingViewWidth
        : (1 / 2 * landingViewWidth > 746)
            ? 746
            : 1 / 2 * landingViewWidth;
    double lsRightSAWOffset =
        (1 / 8 * landingViewWidth > 112) ? 112 : 1 / 8 * landingViewWidth;

    final landscapeLayout = [
      Positioned(
        child: Image.asset("assets/images/landing_art/ls_left_big_art.png"),
        width: lsLeftBigArtWidth,
        left: 0,
      ),
      Positioned(
          child: Column(
            children: [
              Image.asset(
                "assets/images/landing_art/ls_left_small_art.png",
                width: lsLeftSmallArtWidth,
              ),
              SizedBox(height: 24),
            ],
          ),
          left: 12),
      Positioned(
          child: Image.asset(
            "assets/images/landing_art/ls_right_big_art.png",
            width: lsRightBigArtWidth,
          ),
          right: 0),
      Positioned(
        child: Column(
          children: [
            SizedBox(height: 96),
            Image.asset(
              "assets/images/landing_art/ls_right_small_art.png",
              width: lsRightSmallArtWidth,
            ),
          ],
        ),
        right: lsRightSAWOffset,
      ),
      Center(
        child: Image.asset(
          "assets/images/landing_art/welcome_sparta.png",
          width: welcomeSpartaWidth,
        ),
      ),
      Positioned(
          child: Image.asset("assets/images/landing_art/scroll.png"),
          bottom: 32)
    ];

    final portraitLayout = [
      Positioned(
        child: Image.asset(
          "assets/images/landing_art/welcome_sparta.png",
          width: welcomeSpartaWidth,
        ),
        top: 1 / 5 * landingViewHeight,
      ),
      Positioned(
        child: Image.asset(
          "assets/images/landing_art/pt_right_big_art.png",
        ),
        bottom: -16,
        right: 0,
      ),
      Positioned(
        child: Image.asset(
          "assets/images/landing_art/pt_left_big_art.png",
        ),
        bottom: -16,
        left: 0,
      ),
      Positioned(
        child: Image.asset(
          "assets/images/landing_art/pt_right_small_art.png",
        ),
        bottom: 196,
        right: 64,
      ),
      Positioned(
        child: Image.asset(
          "assets/images/landing_art/pt_left_small_art.png",
        ),
        bottom: 196,
        left: 8,
      ),
      Positioned(
        bottom: 1 / 3 * landingViewHeight,
        child: Image.asset(
          "assets/images/landing_art/scroll.png",
          width: 72,
        ),
      ),
    ];

    return Container(
      height: landingViewHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: landingViewHeight,
            width: landingViewWidth,
            child: Image.asset(
              (deviceType == DeviceType.mobile)
                  ? "assets/icons/small_square.png"
                  : "assets/icons/square.png",
              repeat: ImageRepeat.repeat,
            ),
          ),
          if (deviceType == DeviceType.mobile)
            for (Widget widget in portraitLayout) widget
          else
            for (Widget widget in landscapeLayout) widget
        ],
      ),
    );
  }
}
