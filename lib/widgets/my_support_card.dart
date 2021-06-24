import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/support.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/support/services/fetchUser.dart';


class MySupportCard extends StatelessWidget {
  const MySupportCard({
    this.suppInfo,
    this.isPengirim,
  });

  final Support suppInfo;
  final bool isPengirim;

  @override
  Widget build(BuildContext context) {
    Future<User> suppResp;
    User user;

    suppResp = fetchUser( (isPengirim) ? suppInfo.pengirim : suppInfo.penerima);
    suppResp.then((User val){
      user = val;
    });

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

    return FutureBuilder(
      future: suppResp,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Wrap(
            children: <Widget>[
              Container(
                padding: (deviceType == DeviceType.mobile)
                ? EdgeInsets.all(10.0)
                : EdgeInsets.all(15.0),
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
                        Text(user.nim + " " + user.namaLengkap, style: TextStyle(
                          fontSize: respFont * 1.7,
                        )),
                        MyButton(text: 'SUPPORT', buttonType: ButtonType.black,),
                      ],
                    ),
                    SizedBox(height: space/2,),
                    Text(suppInfo.text, style: TextStyle(
                      fontSize: respFont * 2,
                    )),
                  ],
                ),
              ),
            ],
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        );
      }
    );
  }
}