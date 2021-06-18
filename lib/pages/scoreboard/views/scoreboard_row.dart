import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_support_dialog.dart';

class ScoreboardRow extends StatelessWidget {
  const ScoreboardRow({
    this.id,
    this.text,
    this.bgColor,
    this.self,
    this.nickname,
    this.skor,
  });

  final String id;
  final String text;
  final String nickname;
  final int skor;
  final Color bgColor;
  final bool self;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    EdgeInsets respPad = EdgeInsets.symmetric(
      horizontal: (deviceType == DeviceType.mobile) ? 10 : 20,
      vertical: (deviceType == DeviceType.mobile) ? 5 : 15,
    );
    EdgeInsets respMargin = EdgeInsets.symmetric(
        vertical: (deviceType == DeviceType.mobile) ? 5 : 10);
    double respHeight = (deviceType == DeviceType.mobile) ? 50 : 70;
    double respWidth = (deviceType == DeviceType.mobile)
        ? 350
        : (deviceType == DeviceType.tablet)
            ? 600
            : 1000;
    double respText = (deviceType == DeviceType.mobile)
        ? 12
        : (deviceType == DeviceType.tablet)
            ? 14
            : 20;
    double respID = (deviceType == DeviceType.mobile)
        ? 13
        : (deviceType == DeviceType.tablet)
            ? 16
            : 25;
    Color fontColor = this.self ? Colors.white : Colors.black;

    return Container(
      width: respWidth,
      height: respHeight,
      padding: respPad,
      margin: respMargin,
      decoration: BoxDecoration(
        color: this.self ? Colors.black : bgColor,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: this.self
          ? SelfRow(
              id: id,
              width: respWidth,
              respID: respID,
              respText: respText,
              mult: (deviceType == DeviceType.mobile) ? 0.15 : 0.1,
              fontColor: fontColor,
            )
          : OtherRow(
              id: id,
              text: text,
              skor: skor,
              width: respWidth,
              respID: respID,
              respText: respText,
              mult: (deviceType == DeviceType.mobile) ? 0.15 : 0.1,
              fontColor: fontColor,
              nickname: this.nickname,
            ),
    );
  }
}

class OtherRow extends StatelessWidget {
  const OtherRow({
    @required this.id,
    @required this.respID,
    @required this.respText,
    @required this.skor,
    @required this.fontColor,
    @required this.width,
    @required this.mult,
    @required this.text,
    @required this.nickname,
  });

  final String id;
  final String nickname;
  final int skor;
  final double respID;
  final double respText;
  final double width;
  final double mult;
  final Color fontColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width * this.mult,
          child: Text(
            id,
            style: TextStyle(
              fontFamily: "DrukWideBold",
              fontSize: respID,
              color: fontColor,
            ),
          ),
        ),
        Container(
          width: width * 0.35,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: respText,
              color: fontColor,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                skor.toString() + " pts",
                style: TextStyle(
                  fontFamily: "DrukWideBold",
                  fontSize: respText - 5,
                ),
              ),
              SizedBox(
                width: respText - 5,
              ),
              MyButton(
                text: "Support",
                buttonType: ButtonType.black,
                handler: () {
                  showMySupportDialog(context, this.nickname);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SelfRow extends StatelessWidget {
  const SelfRow({
    @required this.id,
    @required this.respID,
    @required this.respText,
    @required this.width,
    @required this.mult,
    @required this.fontColor,
  });

  final String id;
  final double respID;
  final double respText;
  final double width;
  final double mult;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: width * this.mult,
            child: Text(
              id,
              style: TextStyle(
                fontFamily: "DrukWideBold",
                fontSize: respID,
                color: fontColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "DIRIKU SENDIRI",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: respText,
                color: fontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
