import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_support_card.dart';
import 'package:sparta/models/support.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({ Key key }) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool isReceivedDisplayed = false;
  bool isPrevBtnExist = false;
  bool isNextBtnExist = true;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;

    void onReceivedPressed(){
      setState(() {
        isReceivedDisplayed = false;
      });
    }

    void onSentPressed(){
      setState(() {
        isReceivedDisplayed = true;
      });
    }

    void prevPage(){
      setState(() {
        isNextBtnExist = true;
      });
    }

    void nextPage(){
      setState(() {
        isPrevBtnExist = true;
      });
    }

    return Column(
      children: <Widget>[
        SizedBox(height: space * 2),
        Row(children: [
          SizedBox(width: space * 3),
          MyTitle( text: (isReceivedDisplayed) ? "RECEIVED SUPPORTS" : "SENT SUPPORTS"),
        ],),
        SizedBox(height: space),
        Row(children: [
          SizedBox(width: space * 3),
          MyButton(handler: onReceivedPressed, text: 'RECEIVED', buttonType: (isReceivedDisplayed) ? ButtonType.black : ButtonType.white),
          SizedBox(width: space),
          MyButton(handler: onSentPressed, text: 'SENT', buttonType: (isReceivedDisplayed) ? ButtonType.white : ButtonType.black),
        ],),
        SizedBox(height: space),

        // Support Cards (PageView)
        Container(
          padding: EdgeInsets.symmetric(horizontal: space * 3),
          child: MySupportCard(suppInfo: Support(
              id : '999',
              penerima : '60c61fda18522401d587ae56',
              pengirim : '60d326eef742e7001509ca0f',
              text : 'hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije',
            ), isPengirim: isReceivedDisplayed,
          ),
        ),
        

        SizedBox(height: space),

        /* PAGE HANDLING BUTTONS */
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: space * 3),
                  if (isPrevBtnExist)
                    MyButton(
                      handler: prevPage,
                      buttonType: ButtonType.white,
                      text: 'Prev Page',
                    )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (isNextBtnExist)
                    MyButton(
                      handler: nextPage,
                      buttonType: ButtonType.white,
                      text: 'Next Page',
                    ),
                  SizedBox(width: space * 3),
                ]),
          ]),

          SizedBox(height: space),
        
      ],
    );
  }
}