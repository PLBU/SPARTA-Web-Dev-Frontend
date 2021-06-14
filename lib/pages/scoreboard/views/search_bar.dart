import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MySearchBar extends StatelessWidget {
  final searchBarTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    EdgeInsets respPad = (deviceType == DeviceType.mobile)
        ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
        : EdgeInsets.symmetric(vertical: 5, horizontal: 5);
    double respWidth = (deviceType == DeviceType.mobile)
        ? 355
        : (deviceType == DeviceType.tablet)
            ? 605
            : 1010;

    double respFont = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 13
            : 16;

    return Container(
      padding: respPad,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: (deviceType == DeviceType.mobile) ? 50 : 80,
      width: respWidth,
      child: searchBar(context, respFont * 2),
    );
  }

  TextFormField searchBar(BuildContext context, double respFont) {
    return TextFormField(
      controller: this.searchBarTEC,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0),
        border: OutlineInputBorder(),
        prefixIcon: new IconButton(
          padding: EdgeInsets.only(bottom: 1),
          highlightColor: Colors.transparent,
          icon: new Icon(Icons.search, size: respFont),
          onPressed: () {},
          splashColor: Colors.transparent,
        ),
        hintText: 'Cari..',
        hintStyle: TextStyle(fontFamily: "Roboto"),
        helperText: "Dapat mencari dengan jurusan=IF; nama=test;",
        helperStyle: TextStyle(fontFamily: "Roboto"),
        suffixIcon: new IconButton(
          padding: EdgeInsets.only(bottom: 1),
          highlightColor: Colors.transparent,
          icon: new Icon(Icons.clear, size: respFont),
          onPressed: () {
            this.searchBarTEC.clear();
          },
          splashColor: Colors.transparent,
        ),
      ),
    );
  }
}
