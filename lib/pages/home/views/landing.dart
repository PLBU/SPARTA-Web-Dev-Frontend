import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double landingViewHeight = MediaQuery.of(context).size.height -
        MyNavigationBar().preferredSize.height;
    double landingViewWidth = MediaQuery.of(context).size.width;

    return Container(
      height: landingViewHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: landingViewHeight,
            width: landingViewWidth,
            child: Image.asset(
              "assets/images/landing_art/grid_background.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              child: Image.asset("assets/images/landing_art/left_big_art.png"),
              left: 0),
          Positioned(
              child: Column(
                children: [
                  Image.asset("assets/images/landing_art/left_small_art.png"),
                  SizedBox(height: 24),
                ],
              ),
              left: 12),
          Positioned(
              child: Image.asset("assets/images/landing_art/right_big_art.png"),
              right: 0),
          Positioned(
              child: Column(
                children: [
                  SizedBox(height: 96),
                  Image.asset("assets/images/landing_art/right_small_art.png"),
                ],
              ),
              right: 112),
          Center(
              child:
                  Image.asset("assets/images/landing_art/welcome_sparta.png")),
          Positioned(
              child: Image.asset("assets/images/landing_art/scroll.png"),
              bottom: 32)
        ],
      ),
    );
  }
}
