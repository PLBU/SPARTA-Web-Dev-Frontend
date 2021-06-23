import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_heading_text.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    inspect(user);
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.desktop) ? 32 : 24;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileText(
              text: 'Markissa',
              fontFamily: 'DrukWideBold',
            ),
            Spacer(),
            ProfileText(
              text: 'Birthday 08/11',
              fontFamily: 'DrukWideBold',
            ),
          ],
        ),
        SizedBox(height: space),
        ProfileText(
          text: '#' + user.username,
          color: Colors.grey,
          fontSize: 19,
        ),
        MyHeadingText(content: user.namaLengkap),
        ProfileText(
          text: 'dipanggil ' + user.namaPanggilan,
          fontSize: 19,
        ),
        SizedBox(height: space),
        ProfileText(
            text: 'Kelompok ' + user.kelompok.toString() + ' - ' + user.nim),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: space),
          child: Column(
            children: [
              Row(
                children: [
                  ProfileText(text: 'Skor'),
                  Spacer(),
                  ProfileText(text: user.skor.toString() + '/500')
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 18,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor: user.skor / 500,
                  child: Container(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText(
      {Key key,
      @required this.text,
      this.color,
      this.fontSize = 20,
      this.fontFamily = 'Roboto'})
      : super(key: key);

  final String text;
  final color;
  final fontSize;
  final fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontFamily: fontFamily, fontSize: fontSize),
    );
  }
}