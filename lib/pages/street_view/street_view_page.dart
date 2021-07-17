import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:universal_ui/universal_ui.dart';

class StreetViewPage extends StatefulWidget {
  const StreetViewPage({ Key key }) : super(key: key);

  @override
  _StreetViewPageState createState() => _StreetViewPageState();
}

class _StreetViewPageState extends State<StreetViewPage> {
  String viewID = "your-view-id";

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewID,
            (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'assets/html/index.html'
          ..style.border = 'none');

    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ) 
          ),
          HtmlElementView(
            viewType: viewID,
          ),
        ],
      )
      
    );
  }
}