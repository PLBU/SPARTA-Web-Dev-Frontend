import 'package:flutter/material.dart';
import 'package:sparta/pages/home/home.dart';
import 'package:sparta/pages/auth/auth.dart';
import 'package:sparta/provider/route_state.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_drawer.dart';
import 'package:sparta/utils/ui_utils.dart';

void main() {
  runApp(MyApp());
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
              RouteState.changeRouteState(settings.name);
              return BasePage((settings.name == '/')
                  ? HomePage()
                  : (settings.name == '/scoreboard')
                      ? HomePage()
                      : (settings.name == '/upload-tugas')
                          ? HomePage()
                          : (settings.name == '/gallery')
                              ? HomePage()
                              : (settings.name == '/auth')
                                  ? AuthPage()
                                  : null);
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: MyNavigationBar(),
      endDrawer: (deviceType == DeviceType.desktop) ? null : MyDrawer(),
      body: pageContent,
    );
  }
}

// TODO PROXY SERVER CONST