import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/pages/home/home.dart';
import 'package:sparta/pages/scoreboard/scoreboard_page.dart';
import 'package:sparta/pages/auth/auth_page.dart';
import 'package:sparta/widgets/my_footer.dart';
import 'package:sparta/widgets/my_navigation_bar.dart';
import 'package:sparta/widgets/my_drawer.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/provider/route_state.dart';

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
            pageBuilder: (_, __, ___) => BasePage((settings.name == '/')
                ? HomePage()
                : (settings.name == '/scoreboard')
                    ? ScoreboardPage()
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