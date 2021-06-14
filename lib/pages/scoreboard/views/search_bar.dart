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

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      height: 50,
      width: respWidth,
      child: Row(
        children: [
          Container(
            width: respWidth * 0.5,
            child: searchBar(context),
          ),
          SizedBox(width: 18),
          Text(
            "Dapat mencari dengan jurusan=IF; nama=test;",
            style: TextStyle(fontFamily: "Roboto", fontSize: 18),
          )
        ],
      ),
    );
  }

  TextFormField searchBar(BuildContext context) {
    return TextFormField(
      controller: this.searchBarTEC,
      decoration: InputDecoration(
        suffixIcon: new IconButton(
          highlightColor: Colors.transparent,
          icon: new Container(width: 36.0, child: new Icon(Icons.clear)),
          onPressed: () {
            this.searchBarTEC.clear();
          },
          splashColor: Colors.transparent,
        ),
        hintText: 'Enter a search term',
        prefixIcon: new IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
