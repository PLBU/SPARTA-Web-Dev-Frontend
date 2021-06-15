import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/pages/scoreboard/views/top_three.dart';
import 'package:sparta/pages/scoreboard/views/search_bar.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard.dart';
import 'package:sparta/widgets/my_title.dart';

class ScoreboardPage extends StatelessWidget {
  const ScoreboardPage();

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;
    const backgroundColor = Color(0xFFFFCD17);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        color: backgroundColor,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: space * 2),
                MyTitle(text: "SCOREBOARD"),
                SizedBox(height: space),
                TopThree(
                  User(
                    name: "Jonathan C J",
                    nim: "13519144",
                    photo: Image.asset(
                      'assets/images/blank_profile.jpg',
                    ),
                  ),
                  User(
                    name: "Nama Lengkap Banget Dong gila",
                    nim: "13519145",
                    photo: Image.asset(
                      'assets/images/blank_profile.jpg',
                    ),
                  ),
                  User(
                    name: "Test3",
                    nim: "13519146",
                    photo: Image.asset(
                      'assets/images/blank_profile.jpg',
                    ),
                  ),
                ),
                SizedBox(height: space),
                MySearchBar(),
                SizedBox(height: 10),
                ScoreboardRow(
                  id: "205",
                  text: "13519144 Jonathan C J",
                  bgColor: Colors.green,
                  self: true,
                ),
                SizedBox(height: 10),
                //Scoreboard(),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
