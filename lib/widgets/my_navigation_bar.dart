import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_heading_text.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/provider/route_state.dart';

class MyNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  MyNavigationBar({Key key})
      : preferredSize = Size.fromHeight(72),
        super(key: key);

  @override
  final Size preferredSize;
  final bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    Container navBarMenuButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
            size: 32,
          )),
    );

    List<Widget> navBarItems = [
      MyNavBarItem(
        text: "home",
        routeName: "/",
      ),
      MyNavBarItem(
        text: "scoreboard",
        routeName: "/scoreboard",
      ),
      MyNavBarItem(
        text: "upload tugas",
        routeName: "/upload-tugas",
      ),
      MyNavBarItem(
        text: "gallery",
        routeName: "/gallery",
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: (isLoggedIn) ? 8 : 16),
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: MyNavBarItemAuth(isLoggedIn: isLoggedIn),
      ),
    ];

    double imageSize = (deviceType == DeviceType.desktop) ? 48 : 36;

    return ValueListenableBuilder(
        valueListenable: RouteState.current,
        builder: (BuildContext context, dynamic value, Widget child) {
          return AppBar(
            toolbarHeight: 72,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Container(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('icons/sparta_head.png', width: imageSize, height: imageSize),
                  SizedBox(
                    width: 16,
                  ),
                  MyHeadingText(content: "SPARTA", color: Colors.black),
                ],
              ),
            ),
            actions: (deviceType == DeviceType.desktop)
                ? navBarItems
                : [navBarMenuButton],
          );
        });
  }
}

class MyNavBarItemAuth extends StatelessWidget {
  const MyNavBarItemAuth({
    Key key,
    @required bool isLoggedIn,
  })  : _isLoggedIn = isLoggedIn,
        super(key: key);

  final bool _isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return (!_isLoggedIn)
        ? MyButton(
            handler: () {
              Navigator.pushNamed(context, '/auth');
            },
            text: "Login",
            buttonType: ButtonType.white,
          )
        : RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(color: Colors.grey, width: 0.5),
            ),
            elevation: 4.0,
            onPressed: () {},
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/blank_profile.jpg'),
              radius: 50,
            ),
          );
  }
}

class MyNavBarItem extends StatelessWidget {
  const MyNavBarItem({
    @required this.routeName,
    @required this.text,
  });

  final String routeName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: (RouteState.current.value == routeName)
            ? Border(bottom: BorderSide(color: Colors.black, width: 2))
            : null,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8),
          primary: Colors.black12,
        ), //ripple color
        onPressed: () {
          Navigator.pushNamed(context, routeName);
          RouteState.changeRouteState(routeName);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}