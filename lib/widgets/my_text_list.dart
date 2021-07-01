import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyTextList extends StatelessWidget {
  const MyTextList({
    this.title,
    this.list,
  });

  final String title;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    ////// Style
    //// Widget Size
    double textListHeight = (deviceType == DeviceType.mobile)
        ? 200
        : (deviceType == DeviceType.tablet)
            ? 300
            : 380;
    double textListWidth = textListHeight * 1.25;
    double padding = textListWidth * 0.1;

    //// Font Styling
    //- Default style
    Color fontColor = Colors.white;

    //- Title
    double titleBoxHeight = (textListHeight - (1.5 * padding)) / 4;
    double titleFontSize = (deviceType == DeviceType.mobile)
        ? 16
        : (deviceType == DeviceType.tablet)
            ? 24
            : 28;
    TextAlign titleFontAlign = TextAlign.left;
    TextStyle titleFontStyle = TextStyle(
      fontFamily: 'DrukWideBold',
      fontSize: titleFontSize,
      color: fontColor,
    );

    //- Text
    // double listBoxHeight = (textListHeight-(1.5*padding))-titleBoxHeight-2;
    double fontSize = titleFontSize / 1.75;
    TextStyle fontStyle = TextStyle(
        fontFamily: 'Roboto',
        fontSize: fontSize,
        color: fontColor,
        fontWeight: FontWeight.w600);

    ////// Build Implementation
    return Container(
      // Widget Canvas
      // Styling
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(padding, 0.5 * padding, padding, padding),
      // Size
      height: textListHeight + 8,
      width: textListWidth,

      // Child
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Container(
            alignment: Alignment.centerLeft,
            height: titleBoxHeight,
            width: textListWidth - 2 * padding,
            child: Text(
              title,
              textAlign: titleFontAlign,
              style: titleFontStyle,
            ),
          ),
          SizedBox(height: 10),
          // List
          Expanded(
            child: GridView.count(
              // Style
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: fontSize * 0.3,

              // Scroll Control
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: true),
              physics: ScrollPhysics(),

              // Text List
              children: <Widget>[
                for (var string in list)
                  Text(
                    string,
                    textAlign: TextAlign.left,
                    style: fontStyle,
                  )
              ],
            ),
          ),
          if (list.length > 10)
            Center(
              child: Icon(
                Icons.keyboard_arrow_down, 
                color: Colors.white,
                size: (deviceType == DeviceType.mobile) ? 14 : null,
              ),
            )
        ],
      ),
    );
  }
}
