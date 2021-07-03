import 'package:flutter/material.dart';
import 'package:sparta/models/level.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_heading_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.desktop) ? 24 : 20;
    Level currentLevel = new Level(user.skor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (deviceType == DeviceType.desktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.instagramSquare,
                      color: Colors.black,
                      size: 24,
                    ),
                    ProfileText(
                      text: (user.instagram == "")
                          ? ' -'
                          : (' @' + user.instagram),
                      fontFamily: 'DrukWideBold',
                      fontSize: 20,
                    ),
                  ],
                ),
                onTap: () {
                  if (user.instagram != '') launch('https://www.instagram.com/${user.instagram}');
                },
              ),
              Spacer(),
              Icon(Icons.cake),
              ProfileText(
                text: ' ${user.tanggalLahir.day.toString()}/${user.tanggalLahir.month.toString()}/${user.tanggalLahir.year.toString()}',
                fontFamily: 'DrukWideBold',
                fontSize: 20,
              ),
            ],
          ),
        if (deviceType == DeviceType.desktop) SizedBox(height: space),
        (deviceType == DeviceType.desktop)
            ? MyHeadingText(content: user.namaLengkap)
            : ProfileText(
                text: user.namaLengkap,
                fontSize: 19,
                fontFamily: 'DrukWideBold',
              ),
        SizedBox(height: space),
        ProfileText(
          text: 'Nama Panggilan: ' + user.namaPanggilan,
          fontSize: (deviceType != DeviceType.desktop) ? 14 : 19,
        ),
        SizedBox(height: 0.25 * space),
        ProfileText(
          text: 'NIM: ' + user.nim.toString(),
          fontSize: (deviceType != DeviceType.desktop) ? 14 : 19,
        ),
        SizedBox(height: 0.25 * space),
        ProfileText(
          text: 'Kelompok: ' + user.kelompok.toString(),
          fontSize: (deviceType != DeviceType.desktop) ? 14 : 19,
        ),
        SizedBox(height: 0.25 * space),
        ProfileText(
          text: 'Tingkat: ' + Level(user.skor).levelName,
          fontSize: (deviceType != DeviceType.desktop) ? 14 : 19,
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
      this.color = Colors.black,
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
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
    );
  }
}
