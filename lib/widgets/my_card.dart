import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

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
    DeviceType deviceType = UIUtils.getDeviceType(context);

    var cardWidth = this.width != null
        ? width
        : (deviceType == DeviceType.mobile)
            ? 250
            : (deviceType == DeviceType.tablet)
                ? 400
                : 800;
    var cardHeight = this.height != null
        ? height
        : (deviceType == DeviceType.mobile)
            ? 100
            : (deviceType == DeviceType.tablet)
                ? 200
                : 400;

    double textSize = this.width != null
        ? this.width / 32
        : (deviceType == DeviceType.mobile)
            ? 7
            : (deviceType == DeviceType.tablet)
                ? 12
                : 25;

    if (this.type==Type.Bottom && this.height==null){
      var temp = cardWidth;
      cardWidth = cardHeight;
      cardHeight = temp*0.75; 
      textSize -= 2;
    }

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black), boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: const Offset(
            7.0,
            7.0,
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
                  style:
                      TextStyle(fontFamily: 'DrukWideBold', fontSize: textSize),
                ),
                Icon(Icons.close, color: Colors.black)
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: (deviceType == DeviceType.mobile)
                  ? const EdgeInsets.all(15)
                  : (deviceType == DeviceType.tablet)
                      ? const EdgeInsets.all(20)
                      : const EdgeInsets.all(50),
              child: type == Type.Left
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: image,
                        ),
                        SizedBox(
                            width: (deviceType == DeviceType.mobile) ? 20 : 50),
                        Expanded(
                            child: Text(
                          content,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'Roboto', fontSize: textSize),
                        ))
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: image,
                        ),
                        SizedBox(
                          height: (deviceType == DeviceType.mobile) ? 20 : 50,
                        ),
                        Expanded(
                          child: Text(
                            content,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: 'Roboto', fontSize: textSize),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
