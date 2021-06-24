import 'package:flutter/material.dart';
import 'package:sparta/models/level.dart';
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
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.desktop) ? 32 : 24;
    Level currentLevel = new Level(user.skor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (deviceType == DeviceType.desktop)
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ProfileText(
                text: currentLevel.levelName,
                fontFamily: 'DrukWideBold',
                fontSize: 20,
              ),
              Spacer(),
              ProfileText(
                text: 'Ultah 08/11',
                fontFamily: 'DrukWideBold',
                fontSize: 20,
              ),
            ],
          ),
        if (deviceType == DeviceType.desktop) SizedBox(height: space),
        ProfileText(
          text: '#' + user.username,
          color: Colors.grey,
          fontSize: (deviceType != DeviceType.desktop) ? 14 : 19,
        ),
        (deviceType == DeviceType.desktop)
            ? MyHeadingText(content: user.namaLengkap)
            : ProfileText(
                text: user.namaLengkap,
                fontSize: 19,
                fontFamily: 'DrukWideBold',
              ),
        ProfileText(
          text: 'dipanggil ' + user.namaPanggilan,
          fontSize: (deviceType != DeviceType.desktop) ? 14 : 19,
        ),
        SizedBox(height: space),
        ProfileText(
          text: 'Kelompok ' + user.kelompok.toString() + ' - ' + user.nim,
          fontSize: (deviceType != DeviceType.desktop) ? 15 : 20,
        ),
        (deviceType == DeviceType.desktop) ? Spacer() : SizedBox(height: space),
        Padding(
          padding: EdgeInsets.only(bottom: space),
          child: Column(
            children: [
              Row(
                children: [
                  ProfileText(
                    text: 'Skor',
                    fontSize: (deviceType != DeviceType.desktop) ? 15 : 20,
                  ),
                  Spacer(),
                  ProfileText(
                    fontSize: (deviceType != DeviceType.desktop) ? 15 : 20,
                    text: user.skor.toString() +
                        '/${currentLevel.nextLevelRequiredScore}',
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor:
                      (user.skor / currentLevel.nextLevelRequiredScore > 1)
                          ? 1
                          : user.skor / currentLevel.nextLevelRequiredScore,
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
