import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

enum CardType { Right, Bottom }

class MyCard extends StatelessWidget {
  const MyCard({
    this.title,
    this.image,
    this.content,
    this.textSpan,
    this.type,
    this.height,
    this.isCenter,
  });

  final String title;
  final Image image;
  final String content;
  final List<TextSpan> textSpan;
  final CardType type;
  final height;
  final isCenter;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double cardWidth = (deviceType == DeviceType.mobile)
        ? 260
        : (type == CardType.Bottom)
            ? (deviceType == DeviceType.tablet)
                ? 300
                : 320
            : (deviceType == DeviceType.tablet)
                ? 480
                : 680;

    double textSize = (deviceType == DeviceType.mobile)
        ? 14
        : (deviceType == DeviceType.tablet)
            ? 16
            : 18;

    EdgeInsets contentPadding = (deviceType == DeviceType.mobile)
        ? const EdgeInsets.all(20)
        : (deviceType == DeviceType.tablet)
            ? const EdgeInsets.all(28)
            : const EdgeInsets.all(35);

    BoxDecoration shadowDecoration = BoxDecoration(
      border: Border.all(color: Colors.black, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: const Offset(
            8.0,
            8.0,
          ),
        ),
        BoxShadow(
          color: Colors.white,
          offset: const Offset(
            0.0,
            0.0,
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 8, right: 8),
      child: Container(
        width: cardWidth,
        decoration: shadowDecoration,
        child: Column(
          children: [
            CardTitle(title: title, textSize: textSize),
            if (this.type == CardType.Right && deviceType != DeviceType.mobile)
              RightTypeContent(
                textSpan: textSpan,
                contentPadding: contentPadding,
                image: image,
                deviceType: deviceType,
                content: content,
                textSize: textSize,
                height: height,
                isCenter: isCenter,
              )
            else
              BottomTypeContent(
                textSpan: textSpan,
                contentPadding: contentPadding,
                image: image,
                deviceType: deviceType,
                content: content,
                textSize: textSize,
                height: height,
                isCenter: isCenter,
              )
          ],
        ),
      ),
    );
  }
}

class BottomTypeContent extends StatelessWidget {
  const BottomTypeContent({
    Key key,
    @required this.contentPadding,
    @required this.image,
    @required this.deviceType,
    @required this.content,
    @required this.textSize,
    this.textSpan,
    this.height,
    this.isCenter,
  }) : super(key: key);

  final EdgeInsets contentPadding;
  final Image image;
  final DeviceType deviceType;
  final String content;
  final List<TextSpan> textSpan;
  final double textSize;
  final height;
  final isCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: image,
          ),
          SizedBox(
            height: contentPadding.top, // Same value with contentPadding
          ),
          Container(
            child: (textSpan != null)
                ? RichText(
                    textAlign: (isCenter != null)
                        ? TextAlign.center
                        : TextAlign.justify,
                    text: TextSpan(
                      children: textSpan,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: textSize,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Text(
                    content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: textSize,
                      color: Colors.black,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class RightTypeContent extends StatelessWidget {
  const RightTypeContent({
    Key key,
    @required this.contentPadding,
    @required this.image,
    @required this.deviceType,
    @required this.content,
    @required this.textSize,
    this.textSpan,
    this.height,
    this.isCenter,
  }) : super(key: key);

  final EdgeInsets contentPadding;
  final Image image;
  final DeviceType deviceType;
  final String content;
  final List<TextSpan> textSpan;
  final double textSize;
  final height;
  final isCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: image,
          ),
          SizedBox(
            width: contentPadding.top, // Same value with contentPadding
          ),
          Expanded(
            child: (textSpan != null)
                ? RichText(
                    textAlign: (isCenter != null)
                        ? TextAlign.center
                        : TextAlign.justify,
                    text: TextSpan(
                      children: textSpan,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: textSize,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Text(
                    content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: textSize,
                      color: Colors.black,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  const CardTitle({
    Key key,
    @required this.title,
    @required this.textSize,
  }) : super(key: key);

  final String title;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'DrukWideBold',
              fontSize: textSize - 4,
              color: Colors.black,
            ),
          ),
          Text(
            'X',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: textSize,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
