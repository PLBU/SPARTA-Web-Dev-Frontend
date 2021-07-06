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
          text: "Home",
          routeName: "/",
        ),
        MyNavBarItem(
          text: "Scoreboard",
          routeName: "/scoreboard",
        ),
        if (currentUser != null || type == 'admin')
          MyNavBarItem(
            text: "Upload tugas",
            routeName: "/upload-tugas",
          ),
        MyNavBarItem(
          text: "Gallery",
          routeName: "/gallery",
        ),
        MyNavBarItemAuth(currentUser, type),
      ];

      return AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Colors.black,
            height: 2,
          ),
          preferredSize: Size.fromHeight(2),
        ),
        elevation: 0,
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          padding: (deviceType == DeviceType.mobile) ? EdgeInsets.zero : EdgeInsets.only(left: 12),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              NavUtil.navigate(context, '/');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/sparta_head.png',
                    width: imageSize, height: imageSize),
                SizedBox(
                  width: 16,
                ),
                MyHeadingText(content: "SPARTA"),
              ],
            ),
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
              : ProfileButton(currentUser: currentUser),
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
            ? Border(bottom: BorderSide(color: Colors.black, width: 5))
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

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key key,
    @required this.currentUser,
  }) : super(key: key);

  final currentUser;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String newValue) {
        if (newValue == "Profile")
          NavUtil.navigate(context, '/profile/${currentUser.id}');
        else if (newValue == "Logout") AuthState.logout(context);
      },
      tooltip: "Show Profile Menu",
      padding: EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: (currentUser.picture != null)
                  ? NetworkImage(currentUser.picture)
                  : AssetImage('assets/images/blank_profile.jpg'),
              radius: 40,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 32,
            color: Colors.black,
          ),
        ],
      ),
      offset: Offset(0, 64),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "Profile",
          child: Text('Profile'),
        ),
        const PopupMenuItem<String>(
          value: "Logout",
          child: Text('Logout'),
        ),
      ],
    );
  }
}
