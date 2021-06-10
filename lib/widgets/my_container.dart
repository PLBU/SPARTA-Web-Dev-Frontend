import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    this.width,
    this.height
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black,
            blurRadius: 0.0,
            offset: Offset(0.0,2.0),
          ),
        ],
      ),
    );
  }
}