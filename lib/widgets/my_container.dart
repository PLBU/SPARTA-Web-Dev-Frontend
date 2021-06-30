import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MyContainer extends StatelessWidget {

  const MyContainer({
    this.width,
    this.height,
    this.child,
    this.padding
  });

  final padding;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Container(
      width: this.width,
      height: this.height,
      child: this.child,
      padding: (this.padding != null) 
          ? this.padding
          : (deviceType == DeviceType.desktop)
          ? EdgeInsets.all(15.0)
          : EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
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
    );
  }
}
