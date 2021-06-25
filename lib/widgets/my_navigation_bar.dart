import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/utils/nav_util.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final currentUser = watch(AuthState.currentUser).state;
      final type = watch(AuthState.type).state;

      DeviceType deviceType = UIUtils.getDeviceType(context);
      double imageSize = (deviceType == DeviceType.desktop) ? 48 : 36;

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
        if (currentUser != null || type == 'admin')
          MyNavBarItem(
            text: "upload tugas",
            routeName: "/upload-tugas",
          ),
        MyNavBarItem(
          text: "gallery",
          routeName: "/gallery",
        ),
        MyNavBarItemAuth(currentUser, type),
      ];

      return AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/sparta_head.png',
                  width: imageSize, height: imageSize),
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
  MyNavBarItemAuth(this.currentUser, this.type);

  final currentUser;
  final type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: (currentUser != null) ? 8 : 16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: (type == 'admin')
          ? MyButton(
              handler: () {
                AuthState.logout(context);
              },
              text: "Logout",
              buttonType: ButtonType.white,
            )
          : (currentUser == null)
              ? MyButton(
                  handler: () {
                    NavUtil.navigate(context, '/auth');
                  },
                  text: "Login",
                  buttonType: ButtonType.white,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: (currentUser.foto != null)
                            ? MemoryImage(currentUser.foto)
                            : AssetImage('assets/images/blank_profile.jpg'),
                        radius: 40,
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String newValue) {
                        if (newValue == "Profile")
                          NavUtil.navigate(
                              context, '/profile/${currentUser.id}');
                        else if (newValue == "Logout")
                          AuthState.logout(context);
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      offset: Offset(0, 48),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: "Profile",
                          child: Text('Profile'),
                        ),
                        const PopupMenuItem<String>(
                          value: "Logout",
                          child: Text('Logout'),
                        ),
                      ],
                    )
                  ],
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
        border: (RouteState.current == routeName)
            ? Border(bottom: BorderSide(color: Colors.black, width: 2))
            : null,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8),
          primary: Colors.grey[50],
        ), //ripple color
        onPressed: () {
          NavUtil.navigate(context, routeName);
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
