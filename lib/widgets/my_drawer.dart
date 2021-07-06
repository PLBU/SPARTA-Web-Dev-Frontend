import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/provider/route_state.dart';
import 'package:sparta/utils/nav_util.dart';
import 'package:sparta/widgets/my_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final currentUser = watch(AuthState.currentUser).state;
        final type = watch(AuthState.type).state;

        List<Widget> navBarItems = [
          if (currentUser != null)
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: RawMaterialButton(
                shape: CircleBorder(),
                elevation: 4.0,
                onPressed: () {
                  NavUtil.navigate(context, '/profile/${currentUser.id}');
                },
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/images/blank_profile.jpg'),
                    child: (currentUser.picture != null)
                        ? CircleAvatar(
                            minRadius: double.infinity,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(currentUser.picture),
                          )
                        : null,
                    radius: 40,
                  ),
                ),
              ),
            ),
          MyDrawerItem(
            text: "Home",
            routeName: "/",
          ),
          MyDrawerItem(
            text: "Scoreboard",
            routeName: "/scoreboard",
          ),
          if (currentUser != null || type == 'admin')
            MyDrawerItem(
              text: "Upload tugas",
              routeName: "/upload-tugas",
            ),
          MyDrawerItem(
            text: "Gallery",
            routeName: "/gallery",
          ),
          Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: (currentUser != null || type == 'admin')
                ? MyButton(
                    handler: () {
                      AuthState.logout(context);
                    },
                    text: "Logout",
                    buttonType: ButtonType.white,
                  )
                : MyButton(
                    handler: () {
                      NavUtil.navigate(context, '/auth');
                    },
                    text: "Login",
                    buttonType: ButtonType.white,
                  ),
          )
        ];

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
        border: (RouteState.current == routeName)
            ? Border(bottom: BorderSide(color: Colors.black, width: 2))
            : null,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8),
          primary: Colors.black12,
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
