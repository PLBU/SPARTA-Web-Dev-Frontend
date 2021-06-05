import 'package:flutter/material.dart';

enum Type { Left, Bottom }

class MyCard extends StatelessWidget {
  const MyCard(
      {this.width,
      this.height,
      this.title,
      this.image,
      this.content,
      this.type});

  final String title;
  final Image image;
  final String content;
  final Type type;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black), boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: const Offset(
            5.0,
            5.0,
          ),
          blurRadius: 0.0,
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: Colors.white,
          offset: const Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ),
      ]),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontFamily: 'DrukWideBold'),
                ),
                Icon(Icons.close, color: Colors.black)
              ],
            ),
          ),
          Expanded(
              child: type == Type.Left
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [image, Text(content)],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [image, Text(content)],
                    )),
        ],
      ),
    );
  }
}
