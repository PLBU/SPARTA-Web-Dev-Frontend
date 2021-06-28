import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/widgets/my_container.dart';

class ScoreboardSearch extends StatelessWidget {
  const ScoreboardSearch({
    @required this.searchBarTEC,
    @required this.respFont,
    this.submitHandler,
    this.connectionState,
  });

  final TextEditingController searchBarTEC;
  final double respFont;
  final submitHandler;
  final connectionState;

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
          width: (deviceType == DeviceType.mobile)
              ? 350
              : (deviceType == DeviceType.tablet)
                  ? 600
                  : 1000,
          padding: EdgeInsets.only(
            bottom: 0,
            top: 5,
            left: 5,
            right: 5,
          ),
          child: Column(
            children: [
              MyTextField(
                minLines: 1,
                maxLines: 1,
                hintText: "Cari..",
                helperText:
                    "Format Pencarian: \"jurusan=IF; nama=test; nim=113; kelompok=15;\"",
                width: (deviceType == DeviceType.mobile)
                    ? 330
                    : (deviceType == DeviceType.tablet)
                        ? 550
                        : 950,
                margin: (deviceType == DeviceType.mobile)
                    ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
                    : EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                controller: this.searchBarTEC,
                submitHandler: (text) {
                  this.submitHandler(text);
                },
                prefixIcon: new Icon(
                  Icons.search,
                  size: respFont * 1.5,
                  color: Colors.black,
                ),
                suffixIcon: new IconButton(
                  color: Colors.black,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: new Icon(
                    Icons.clear,
                    size: respFont * 1.5,
                  ),
                  onPressed: () {
                    this.searchBarTEC.clear();
                    this.submitHandler(null);
                  },
                ),
              ),
              if (connectionState != ConnectionState.done)
                Container(
                  width: double.infinity,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    backgroundColor: Colors.white,
                  ),
                )
              else
                SizedBox(height: respFont * 0.25),
            ],
          ),
        ),
      ),
    );
  }
}
