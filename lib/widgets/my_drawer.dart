import 'package:flutter/material.dart';
import 'package:sparta/provider/route_state.dart';
import 'package:sparta/widgets/my_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  final bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [
      if (isLoggedIn)
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.yellow[800],
          ),
          child: RawMaterialButton(
            shape: CircleBorder(),
            elevation: 4.0,
            onPressed: () {},
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/blank_profile.jpg'),
              radius: 50,
            ),
          ),
        ),
      MyDrawerItem(
        text: "home",
        routeName: "/",
      ),
      MyDrawerItem(
        text: "scoreboard",
        routeName: "/scoreboard",
      ),
      MyDrawerItem(
        text: "upload tugas",
        routeName: "/upload-tugas",
      ),
      MyDrawerItem(
        text: "gallery",
        routeName: "/gallery",
      ),
      Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: (isLoggedIn)
            ? MyButton(
                handler: () {
                  Navigator.pushNamed(context, '/auth');
                },
                text: "Logout",
                buttonType: ButtonType.white,
              )
            : MyButton(
                handler: () {
                  Navigator.pushNamed(context, '/auth');
                },
                text: "Login",
                buttonType: ButtonType.white,
              ),
      )
    ];

    return ValueListenableBuilder(
      valueListenable: RouteState.current,
      builder: (BuildContext context, dynamic value, Widget child) {
        return Drawer(
          child: ListView(
            children: navBarItems,
          ),
        );
      },
    );
  }
}

class MyDrawerItem extends StatelessWidget {
  const MyDrawerItem({
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
