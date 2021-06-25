import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/pages/support/views/support_card.dart';
import 'package:sparta/models/support.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool _isReceivedDisplayed = true;
  bool _isPrevBtnExist = false;
  bool _isNextBtnExist = true;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;

    void onReceivedPressed() {
      setState(() {
        _isReceivedDisplayed = true;
      });
    }

    void onSentPressed() {
      setState(() {
        _isReceivedDisplayed = false;
      });
    }

    void prevPage() {
      setState(() {
        _isNextBtnExist = true;
      });
    }

    void nextPage() {
      setState(() {
        _isPrevBtnExist = true;
      });
    }

    return Column(
      children: <Widget>[
        SizedBox(height: space * 2),
        Row(
          children: [
            SizedBox(width: space * 3),
            (!(deviceType == DeviceType.mobile))
                ? MyTitle(
                    text: (_isReceivedDisplayed)
                        ? "RECEIVED SUPPORTS"
                        : "SENT SUPPORTS")
                : MyTitle(text: (_isReceivedDisplayed) ? "RECEIVED" : "SENT"),
          ],
        ),
        if (deviceType == DeviceType.mobile) SizedBox(height: space / 2),
        if (deviceType == DeviceType.mobile)
          Row(children: [
            SizedBox(width: space * 3),
            MyTitle(text: "SUPPORTS"),
          ]),
        SizedBox(height: space),
        Row(
          children: [
            SizedBox(width: space * 3),
            MyButton(
                handler: onReceivedPressed,
                text: 'RECEIVED',
                buttonType: (_isReceivedDisplayed)
                    ? ButtonType.black
                    : ButtonType.white),
            SizedBox(width: space),
            MyButton(
                handler: onSentPressed,
                text: 'SENT',
                buttonType: (_isReceivedDisplayed)
                    ? ButtonType.white
                    : ButtonType.black),
          ],
        ),
        SizedBox(height: space),
        // Support Cards (PageView)
        Container(
          padding: EdgeInsets.symmetric(horizontal: space * 3),
          child: SupportCard(
            suppInfo: Support(
              id: '999',
              penerima: '60c61fda18522401d587ae56',
              pengirim: '60d326eef742e7001509ca0f',
              text:
                  'hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije hail bije',
            ),
            isPengirim: _isReceivedDisplayed,
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
                    if (_isPrevBtnExist)
                      MyButton(
                        handler: prevPage,
                        buttonType: ButtonType.white,
                        text: 'Prev Page',
                      )
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                if (_isNextBtnExist)
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
