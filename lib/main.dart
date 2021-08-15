import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/pages/profile/profile_page.dart';
import 'package:sparta/pages/street_view/street_view_page.dart';
import 'package:sparta/pages/support/support_page.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/provider/route_state.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/widgets/my_button.dart';
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

import 'package:url_launcher/url_launcher.dart';

void main() async {
  await AuthState.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

                    if (AuthState.storage.containsKey('hmif_goods')) {
                      AuthState.storage.remove('hmif_goods');
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
                                                        id: routeComponents
                                                            .last)
                                                    : (routeComponents[1] ==
                                                            'street-view')
                                                        ? StreetViewPage()
                                                        : Center(
                                                            child: MyTitle(
                                                              text:
                                                                  "404 Not Found",
                                                            ),
                                                          ),
                        true,
                      );
                    } else {
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
                                                        id: routeComponents
                                                            .last)
                                                    : (routeComponents[1] ==
                                                            'street-view')
                                                        ? StreetViewPage()
                                                        : Center(
                                                            child: MyTitle(
                                                              text:
                                                                  "404 Not Found",
                                                            ),
                                                          ),
                        false,
                      );
                    }
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
  const BasePage(this.pageContent, this.ads);

  final Widget pageContent;
  final bool ads;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    if (ads) {
      Future.delayed(
        Duration(milliseconds: 500),
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(child: Image.asset('assets/images/hmif_goods/batch1.png', height: 600,), fit: BoxFit.scaleDown),
                    SizedBox(height: 16,),
                    MyButton(
                      buttonType: ButtonType.black,
                      text: "CEK SEKARANG",
                      handler: () async {
                        await launch("https://instagram.com/hmif.goods");
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: MyNavigationBar(),
      endDrawer: (deviceType == DeviceType.desktop) ? null : MyDrawer(),
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
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
        ),
      ),
    );
  }
}
