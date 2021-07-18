import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/widgets/my_container.dart';

class ScoreInput extends StatelessWidget {
  const ScoreInput({this.jwt, this.editBulkScore});

  final jwt;
  final editBulkScore;

  @override
  Widget build(BuildContext context) {
    TextEditingController nimTEC = TextEditingController();
    TextEditingController kelompokTEC = TextEditingController();
    TextEditingController skorTEC = TextEditingController();
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double respWidth = (deviceType == DeviceType.mobile)
        ? 350
        : (deviceType == DeviceType.tablet)
            ? 600
            : 1000;

    return MyContainer(
      width: respWidth,
      padding: EdgeInsets.only(
        bottom: 0,
        top: 5,
        left: 5,
        right: 5,
      ),
      child: ((deviceType != DeviceType.mobile) &&
              (deviceType != DeviceType.tablet))
          ? HorizontalInput(
              kelompokTEC: kelompokTEC,
              nimTEC: nimTEC,
              skorTEC: skorTEC,
              updateHandler: () async {
                await editBulkScore(
                  kelompokTEC.text,
                  nimTEC.text,
                  skorTEC.text,
                  jwt,
                  context,
                );
              })
          : VerticalInput(
              width: respWidth,
              isMobile: deviceType == DeviceType.mobile,
              kelompokTEC: kelompokTEC,
              nimTEC: nimTEC,
              skorTEC: skorTEC,
              updateHandler: () async {
                await editBulkScore(
                  kelompokTEC.text,
                  nimTEC.text,
                  skorTEC.text,
                  jwt,
                  context,
                );
              }),
    );
  }
}

class HorizontalInput extends StatelessWidget {
  const HorizontalInput(
      {Key key,
      this.kelompokTEC,
      this.nimTEC,
      this.skorTEC,
      this.updateHandler,
      this.jwt})
      : super(key: key);

  final jwt;
  final TextEditingController kelompokTEC;
  final TextEditingController nimTEC;
  final TextEditingController skorTEC;
  final updateHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Update Skor berjamaah",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextField(
              width: 200,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              minLines: 1,
              maxLines: 1,
              labelText: "Kelompok",
              helperText: "Separator: ';'",
              controller: kelompokTEC,
            ),
            MyTextField(
              width: 300,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              minLines: 1,
              labelText: "NIM",
              helperText: "Separator: ';' atau '\\n'",
              controller: nimTEC,
            ),
            MyTextField(
              width: 150,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              minLines: 1,
              maxLines: 1,
              helperText: 'Cth:"10" / "-10"',
              labelText: "Perubahan Skor",
              controller: skorTEC,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: MyButton(
                text: "Update",
                buttonType: ButtonType.black,
                handler: this.updateHandler,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class VerticalInput extends StatelessWidget {
  const VerticalInput(
      {Key key,
      this.width,
      this.isMobile,
      this.kelompokTEC,
      this.nimTEC,
      this.skorTEC,
      this.updateHandler,
      this.jwt})
      : super(key: key);

  final jwt;
  final double width;
  final bool isMobile;
  final TextEditingController kelompokTEC;
  final TextEditingController nimTEC;
  final TextEditingController skorTEC;
  final updateHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Update Skor berjamaah",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: (isMobile) ? 12 : 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        MyTextField(
          width: width * 0.75,
          margin: (isMobile)
              ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
              : EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          minLines: 1,
          maxLines: 1,
          labelText: "Kelompok",
          helperText: "Separator: ';', Cth: '1;2;3;'",
          controller: kelompokTEC,
        ),
        MyTextField(
          width: width * 0.75,
          margin: (isMobile)
              ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
              : EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          minLines: 1,
          labelText: "NIM",
          helperText:
              "Separator: ';' atau '\\n', Cth: '13520000;13520999;' atau '13520000\\n13520999'",
          controller: nimTEC,
        ),
        MyTextField(
          width: width * 0.75,
          margin: (isMobile)
              ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
              : EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          minLines: 1,
          maxLines: 1,
          helperText: 'Cth:"10" / "-10"',
          labelText: "Perubahan Skor",
          controller: skorTEC,
        ),
        Container(
          padding: EdgeInsets.only(left: (isMobile) ? 8 : 15, bottom: 10),
          child: MyButton(
            text: "Update",
            buttonType: ButtonType.black,
            handler: this.updateHandler,
          ),
        )
      ],
    );
  }
}
