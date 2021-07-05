import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/send_support/support_dialog.dart';

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
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 15
            : 20;

    return Wrap(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(respPad),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 0.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (user == null)
                    ? Text('Anonymous',
                        style: TextStyle(
                        fontSize: respFont * 1.25,
                        fontWeight: FontWeight.bold,
                      ))
                    : Text(this.user.nim + " " + this.user.namaLengkap,
                        style: TextStyle(
                          fontSize: respFont * 1.25,
                          fontWeight: FontWeight.bold,
                      )),
                  if (!(deviceType == DeviceType.mobile) && user != null)
                    MyButton(
                      text: 'SUPPORT',
                      buttonType: ButtonType.black,
                      handler: (){
                        showSupportDialog(context, this.user.namaPanggilan, this.user.id);
                      },
                    ),
                ],
              ),
              SizedBox(height: space/2),
              Container(
                height: space * 2,
                child: ListView(
                  children: [
                    Text(
                      suppInfo,
                      style: TextStyle(
                        fontSize: respFont * 1.5,
                      )),
                  ],
                ),
              ),
              SizedBox(height: space/2),
              if (deviceType == DeviceType.mobile && user != null ) SizedBox(height: space/2),
              if (deviceType == DeviceType.mobile && user != null )
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
