import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class MySearchBar extends StatelessWidget {
  final searchBarTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    double respWidth = (deviceType == DeviceType.mobile)
        ? 350
        : (deviceType == DeviceType.tablet)
            ? 600
            : 1000;

    double respFont = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 13
            : 18;

    return Container(
      padding: (deviceType == DeviceType.mobile)
          ? EdgeInsets.only(top: 2, bottom: 2, left: 5)
          : EdgeInsets.only(top: 5, bottom: 5, left: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: (deviceType == DeviceType.mobile) ? 30 : 50,
      width: respWidth,
      child: Row(
        children: [
          Container(
            width: respWidth * 0.5,
            child: searchBar(context, respFont * 2),
          ),
          SizedBox(width: respFont),
          Container(
            height: 50,
            width: respWidth * 0.43,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dapat mencari dengan jurusan=IF; nama=test;",
                  style: TextStyle(fontFamily: "Roboto", fontSize: respFont),
                ),
              ],
            ),
          )
        ],
      ),
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
