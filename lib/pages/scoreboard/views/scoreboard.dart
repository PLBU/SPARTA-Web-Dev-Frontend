import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_button.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({this.users, this.ranks, this.curUser});

  final List<User> users;
  final Map<String, int> ranks;
  final User curUser;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    final PageController controller = PageController(initialPage: 0);
    int nPages = 50;
    List<dynamic> usersScoreboard = [];

    for (int i = 0; i <= users.length ~/ nPages; i++) {
      if (i == users.length ~/ nPages)
        usersScoreboard
            .add(this.users.sublist(i * nPages, users.length).map((entry) {
          return ScoreboardRow(
            id: (ranks[entry.nim]).toString(),
            text: entry.nim + " " + entry.namaLengkap,
            nickname: entry.namaPanggilan,
            skor: entry.skor,
            bgColor:
                Colors.white, //entry.skor < 50 ? Colors.red : Colors.green,
            self: false,
          );
        }).toList());
      else
        usersScoreboard
            .add(this.users.sublist(i * nPages, (i + 1) * nPages).map((entry) {
          return ScoreboardRow(
            id: (ranks[entry.nim]).toString(),
            text: entry.nim + " " + entry.namaLengkap,
            nickname: entry.namaPanggilan,
            skor: entry.skor,
            bgColor:
                Colors.white, //entry.skor < 50 ? Colors.red : Colors.green,
            self: false,
          );
        }).toList());
    }

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
              text: "Previous",
              buttonType: ButtonType.black,
              handler: () {
                controller.animateToPage(
                  controller.page.toInt() - 1,
                  duration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                );
              },
            ),
            SizedBox(
              width: 50,
            ),
            MyButton(
              text: "Next",
              buttonType: ButtonType.black,
              handler: () {
                controller.animateToPage(
                  controller.page.toInt() + 1,
                  duration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
        Container(
          height: (deviceType == DeviceType.mobile) ? 51 * 50.0 : 51 * 70.0,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: (users.length ~/ nPages) + 1,
            itemBuilder: ((context, index) {
              return Column(
                children: usersScoreboard[index],
              );
            }),
          ),
        ),
      ],
    );
  }
}
