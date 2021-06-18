import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/widgets/my_container.dart';

class ScoreboardSearch extends StatelessWidget {
  const ScoreboardSearch(
      {@required this.searchBarTEC,
      @required this.respFont,
      this.submitHandler});

  final TextEditingController searchBarTEC;
  final double respFont;
  final submitHandler;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          if (!focus && searchBarTEC.text == "") {
            this.submitHandler(null);
          }
        },
        child: MyContainer(
          padding: EdgeInsets.all(respFont),
          child: MyTextField(
            minLines: 1,
            maxLines: 1,
            hintText: "Cari..",
            helperText:
                "Dapat mencari dengan \"jurusan=IF; nama=test; nim=113; kelompok=15;\"",
            width: (deviceType == DeviceType.mobile)
                ? 350
                : (deviceType == DeviceType.tablet)
                    ? 600
                    : 1000,
            margin: (deviceType == DeviceType.mobile)
                ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
                : EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            controller: this.searchBarTEC,
            submitHandler: (text) {
              this.submitHandler(text);
            },
            prefixIcon: new Icon(
              Icons.search,
              size: respFont * 2,
              color: Colors.black,
            ),
            suffixIcon: new IconButton(
              color: Colors.black,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.only(bottom: 1),
              icon: new Icon(
                Icons.clear,
                size: respFont * 2,
              ),
              onPressed: () {
                this.searchBarTEC.clear();
                this.submitHandler(null);
              },
            ),
          ),
        ),
      ),
    );
  }
}
