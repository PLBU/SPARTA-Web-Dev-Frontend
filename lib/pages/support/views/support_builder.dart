import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/pages/support/services/index.dart';
import 'package:sparta/pages/support/views/list_supports.dart';

class SupportBuilder extends StatefulWidget {
  const SupportBuilder({
    this.user,
    this.jwt,
  });

  final user;
  final jwt;

  @override
  _SupportBuilderState createState() => _SupportBuilderState();
}

class _SupportBuilderState extends State<SupportBuilder> {
  Future<List<dynamic>> lists;

  bool _isReceivedDisplayed = true;

  @override
  void initState() {
    super.initState();
    lists = fetchLists(widget.user.id, widget.jwt, false);
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;

    return FutureBuilder(
        future: lists,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null)
              return Column(
                children: <Widget>[
                  SizedBox(height: space),
                  (deviceType != DeviceType.mobile)
                      ? MyTitle(
                          text: (_isReceivedDisplayed)
                              ? "RECEIVED SUPPORTS"
                              : "SENT SUPPORTS")
                      : Column(
                          children: [
                            MyTitle(
                              text:
                                  (_isReceivedDisplayed) ? "RECEIVED" : "SENT",
                            ),
                            MyTitle(
                              text: "SUPPORTS",
                            )
                          ],
                        ),
                  SizedBox(height: space),
                  Row(
                    children: [
                      SizedBox(width: space * 5),
                      MyButton(
                          handler: () {
                            setState(() {
                              _isReceivedDisplayed = true;
                              lists = fetchLists(widget.user.id, widget.jwt,
                                  !_isReceivedDisplayed);
                            });
                          },
                          text: 'RECEIVED',
                          buttonType: (_isReceivedDisplayed)
                              ? ButtonType.black
                              : ButtonType.white),
                      SizedBox(width: space/2),
                      MyButton(
                          handler: () {
                            setState(() {
                              _isReceivedDisplayed = false;
                              lists = fetchLists(widget.user.id, widget.jwt,
                                  !_isReceivedDisplayed);
                            });
                          },
                          text: 'SENT',
                          buttonType: (_isReceivedDisplayed)
                              ? ButtonType.white
                              : ButtonType.black),
                    ],
                  ),
                  SizedBox(height: space/2),
                  // Support Cards (PageView)
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data.length > 0)
                    ListSupports(
                      isReceivedDisplayed: _isReceivedDisplayed,
                      lists: snapshot.data,
                      space: space,
                    )
                  else if (snapshot.connectionState == ConnectionState.done)
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MyNavigationBar().preferredSize.height -
                          8 * space,
                      child: Center(
                        child: Text(
                          "Belum ada Support yang tersedia",
                          style: TextStyle(
                            fontFamily: "DrukWideBold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MyNavigationBar().preferredSize.height -
                          8 * space,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black), //,
                        ),
                      ),
                    ),
                  // SizedBox(height: space),
                ],
              );
            else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error Occured!"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }

          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black), //,
            ),
          );
        });
  }
}
