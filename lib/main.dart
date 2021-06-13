import 'package:flutter/material.dart';
import 'package:sparta/pages/home/home.dart';
import 'package:sparta/pages/auth/auth.dart';
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
        primaryColor: Colors.black,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => BasePage((settings.name == '/')
                ? HomePage()
                : (settings.name == '/scoreboard')
                    ? HomePage()
                    : (settings.name == '/upload-tugas')
                        ? HomePage()
                        : (settings.name == '/gallery')
                            ? HomePage()
                            : (settings.name == 'auth')
                                ? AuthPage()
                                : null),
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
      appBar: MyNavigationBar(),
      endDrawer: (deviceType == DeviceType.desktop) ? null : MyDrawer(),
      body: pageContent,
    );
  }
}
