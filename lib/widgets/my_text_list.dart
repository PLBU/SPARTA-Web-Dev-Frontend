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
    ///// Get device build
    DeviceType deviceType = UIUtils.getDeviceType(context);
    
    ////// Style
    //// Widget Size
    double textListHeight = 400;
    double textListWidth = 400;
    double padding = 10;
    
    //// Font Styling
    //- Default style
    Color fontColor = Colors.white;

    //- Title
    double titleFontSize = 24;
    TextAlign titleFontAlign = TextAlign.left;
    TextStyle titleFontStyle = TextStyle(
      fontFamily: 'DrukWideBold',
      fontSize: titleFontSize,
      color: fontColor,
      );

    //- Text
    double fontSize = 15;
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
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
      // Size
      height: textListHeight,
      width: textListWidth,

      // Child
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Container(
            padding: EdgeInsets.all(padding),
            child: Text(
              title,
              textAlign: titleFontAlign,
              style: titleFontStyle,
            ),
          ),

          // List
          Container(
            child: Expanded(
              child: GridView(
                // Style
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: fontSize*0.55,
                  ),
                
                // Scrollbar
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: true),
                physics: ScrollPhysics(),
                
                // Text List
                children: <Widget>[
                  for(var string in list)
                    Text(
                      string,
                      textAlign: fontAlign,
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