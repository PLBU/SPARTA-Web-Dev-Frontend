import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_heading_text.dart';
import 'dart:html' as html;
import 'package:universal_ui/universal_ui.dart';

class StreetViewPage extends StatefulWidget {
  const StreetViewPage({Key key}) : super(key: key);

  @override
  _StreetViewPageState createState() => _StreetViewPageState();
}

class _StreetViewPageState extends State<StreetViewPage> {
  String viewID = "your-view-id";

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewID,
        (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'assets/assets/html/funday.html'
          ..style.border = 'none');

    if (deviceType == DeviceType.desktop)
      return SizedBox(
          height: 500,
          child: Stack(
            children: [
              Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              )),
              HtmlElementView(
                viewType: viewID,
              ),
            ],
          ));
    else
      return Center(
        child: MyHeadingText(
          content: "Sorry, HMIF Atlas can only work on Desktop",
        ),
      );
  }
}