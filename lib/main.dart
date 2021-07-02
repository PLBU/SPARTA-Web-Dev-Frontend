import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/pages/profile/profile_page.dart';
import 'package:sparta/pages/support/support_page.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/provider/route_state.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/widgets/my_footer.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_drawer.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/pages/home/home_page.dart';
import 'package:sparta/pages/auth/auth_page.dart';
import 'package:sparta/pages/scoreboard/scoreboard_page.dart';
import 'package:sparta/pages/upload/upload_page.dart';
import 'package:sparta/pages/gallery/gallery_page.dart';
import 'package:sparta/constants/index.dart';
import 'dart:html';

void main() async {
  await AuthState.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<dynamic> loadAllImage(BuildContext context) async {
    final loader = document.getElementsByClassName('loader');
    Completer completer = new Completer();

    for (var asset in allAssets) {
      await precacheImage(asset, context);
    }

    if (loader.isNotEmpty) loader.first.remove();
    completer.complete(ConnectionState.done);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadAllImage(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'SPARTA 2020',
              theme: ThemeData(
                primarySwatch: primarySwatch,
                accentColor: Color.fromRGBO(255, 205, 23, 1),
                colorScheme:
                    ColorScheme.light(primary: Color.fromRGBO(255, 205, 23, 1)),
              ),
              initialRoute: '/',
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) {
                    var routeComponents = settings.name.split('/');
                    final jwt = context.read(AuthState.jwt).state;

                    if (jwt != null && routeComponents[1] == 'auth')
                      routeComponents[1] = '';

                    RouteState.changeRouteState('/' + routeComponents[1]);

                    return BasePage(
                      (routeComponents[1] == '')
                          ? HomePage()
                          : (routeComponents[1] == 'scoreboard')
                              ? ScoreboardPage()
                              : (routeComponents[1] == 'upload-tugas')
                                  ? UploadPage()
                                  : (routeComponents[1] == 'gallery')
                                      ? GalleryPage()
                                      : (routeComponents[1] == 'auth')
                                          ? AuthPage()
                                          : (routeComponents[1] == 'supports')
                                              ? SupportPage()
                                              : (routeComponents[1] ==
                                                      'profile')
                                                  ? ProfilePage(
                                                      id: routeComponents.last)
                                                  : Center(
                                                      child: MyTitle(
                                                        text: "404 Not Found",
                                                      ),
                                                    ),
                    );
                  },
                  settings: settings,
                );
              },
            );
          } else {
            return Container();
          }
        });
  }
}

class BasePage extends StatelessWidget {
  const BasePage(this.pageContent);

  final Widget pageContent;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: MyNavigationBar(),
      endDrawer: (deviceType == DeviceType.desktop) ? null : MyDrawer(),
      body: ListView(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MyNavigationBar().preferredSize.height,
            ),
            child: pageContent,
          ),
          MyFooter()
        ],
      ),
    );
  }
}
