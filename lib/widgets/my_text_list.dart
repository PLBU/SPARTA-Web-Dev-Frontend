import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_title.dart';

class MyTextList extends StatelessWidget {
  const MyTextList ({
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
    double textListHeight =
      (deviceType == DeviceType.mobile)
        ? 400
        : (deviceType == DeviceType.tablet)
            ? 600
            : 760;
    double textListWidth = textListHeight*0.75;
    double padding = textListWidth*0.1;
    
    //// Font Styling
    //- Default style
    Color fontColor = Colors.white;

    //- Title
    double titleBoxHeight = (textListHeight-(1.5*padding))/8;
    double titleFontSize = 
      (deviceType == DeviceType.mobile)
        ? 22
        : (deviceType == DeviceType.tablet)
            ? 28
            : 32;
    TextAlign titleFontAlign = TextAlign.left;
    TextStyle titleFontStyle = TextStyle(
      fontFamily: 'DrukWideBold',
      fontSize: titleFontSize,
      color: fontColor,
      );

    //- Text
    double listBoxHeight = (textListHeight-(1.5*padding))-titleBoxHeight-2;
    double fontSize = titleFontSize/2;
    TextAlign fontAlign = TextAlign.center;
    TextStyle fontStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      color: fontColor,
      );

    ////// Build Implementation
    return Container( // Widget Canvas
      // Styling
      decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.black,
              ),
      padding: EdgeInsets.fromLTRB(padding, 0.5*padding, padding, padding),
      // Size
      height: textListHeight,
      width: textListWidth,

      // Child
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Container(
            alignment: Alignment.centerLeft,
            height: titleBoxHeight,
            width: textListWidth-2*padding,
            child: Text(
              title,
              textAlign: titleFontAlign,
              style: titleFontStyle,
              ),
          ),

          // List
          Container(
            height: listBoxHeight,
            width: textListWidth-2*padding,
            child: Expanded(
              child: GridView.count(
                // Style
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: fontSize*0.45,

                // Scroll Control
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: true),
                physics: ScrollPhysics(),
                
                // Text List
                children: <Widget>[
                  for(var string in list)
                    Text(
                      string,
                      textAlign: TextAlign.left,
                      style: fontStyle,
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