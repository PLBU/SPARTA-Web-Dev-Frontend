import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/support.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/send_support/support_dialog.dart';
import 'package:sparta/pages/support/services/index.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    this.suppInfo,
    this.isPengirim,
    this.user,
  });

  final String suppInfo;
  final bool isPengirim;
  final User user;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;
    double respFont = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 13
            : 16;
    double respPad = (deviceType == DeviceType.mobile)
        ? 20
        : (deviceType == DeviceType.tablet)
            ? 30
            : 40;

    return Wrap(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(respPad),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 0.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(this.user.nim + " " + this.user.namaLengkap,
                      style: TextStyle(
                        fontSize: respFont * 1.7,
                        fontWeight: FontWeight.bold,
                      )),
                  if (!(deviceType == DeviceType.mobile))
                    MyButton(
                      text: 'SUPPORT',
                      buttonType: ButtonType.black,
                      handler: (){
                        showSupportDialog(context, this.user.namaPanggilan, this.user.id);
                      },
                    ),
                ],
              ),
              SizedBox(height: space),
              Text(suppInfo,
                  style: TextStyle(
                    fontSize: respFont * 2,
                  )),
              SizedBox(height: space),
              if (deviceType == DeviceType.mobile) SizedBox(height: space),
              if (deviceType == DeviceType.mobile)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: space),
                    MyButton(
                      text: 'SUPPORT',
                      buttonType: ButtonType.black,
                      handler: (){
                        showSupportDialog(context, this.user.namaLengkap, this.user.id);
                      },
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
