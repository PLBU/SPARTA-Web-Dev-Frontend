import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/provider/route_state.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/widgets/my_footer.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_drawer.dart';
import 'package:sparta/pages/home/home_page.dart';
import 'package:sparta/pages/auth/auth_page.dart';
import 'package:sparta/pages/scoreboard/scoreboard_page.dart';
import 'package:sparta/pages/upload/upload_page.dart';
import 'dart:html';

void main() async {
  await AuthState.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.light(primary: Color.fromRGBO(255, 205, 23, 1)),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              var routeName = settings.name;
              if (context.read(AuthState.jwt).state != null &&
                  routeName == '/auth') routeName = '/';
              RouteState.changeRouteState(routeName);
              return BasePage(
                (routeName == '/')
                    ? HomePage()
                    : (routeName == '/scoreboard')
                        ? ScoreboardPage()
                        : (routeName == '/upload-tugas')
                            ? HomePage()
                            : (routeName == '/gallery')
                                ? HomePage()
                                : (routeName == '/auth')
                                    ? AuthPage()
                                    : null,
              );
            },
            settings: settings);
      },
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage(this.pageContent);

  final Widget pageContent;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    final loader = document.getElementsByClassName('loader');
    if (loader.isNotEmpty) {
      loader.first.remove();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: MyNavigationBar(),
      endDrawer: (deviceType == DeviceType.desktop) ? null : MyDrawer(),
      body: ListView(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: pageContent,
          ),
          MyFooter()
        ],
      ),
    );
  }
}
