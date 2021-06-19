import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_button.dart';

class ScoreboardView extends StatefulWidget {
  ScoreboardView({this.users, this.ranks, this.curUser});

  final List<User> users;
  final Map<String, int> ranks;
  final User curUser;

  @override
  _ScoreboardViewState createState() => _ScoreboardViewState();
}

class _ScoreboardViewState extends State<ScoreboardView> {
  int pageNum = 0;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    final PageController controller = PageController(initialPage: 0);
    int nPages = 50;
    List<dynamic> usersScoreboard = [];

    for (int i = 0; i <= widget.users.length ~/ nPages; i++) {
      if (i == widget.users.length ~/ nPages)
        usersScoreboard.add(
            widget.users.sublist(i * nPages, widget.users.length).map((entry) {
          return ScoreboardRow(
            id: (widget.ranks[entry.nim]).toString(),
            text: entry.nim + " " + entry.namaLengkap,
            nickname: entry.namaPanggilan,
            skor: entry.skor,
            bgColor:
                Colors.white, //entry.skor < 50 ? Colors.red : Colors.green,
            self: false,
          );
        }).toList());
      else
        usersScoreboard.add(
            widget.users.sublist(i * nPages, (i + 1) * nPages).map((entry) {
          return ScoreboardRow(
            id: (widget.ranks[entry.nim]).toString(),
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
        PageButton(
          handler1: () {
            setState(() {
              pageNum = (pageNum - 1) < 0 ? pageNum : (pageNum - 1);
            });
            controller.animateToPage(
              controller.page.toInt() - 1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          handler2: () {
            setState(() {
              pageNum = (pageNum + 1) < ((widget.users.length ~/ nPages) + 1)
                  ? (pageNum + 1)
                  : pageNum;
            });
            controller.animateToPage(
              controller.page.toInt() + 1,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            );
          },
        ),
        Container(
          height: (deviceType == DeviceType.mobile)
              ? (usersScoreboard[pageNum].length + 2) * 50.0
              : (usersScoreboard[pageNum].length + 2) * 70.0,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: (widget.users.length ~/ nPages) + 1,
            itemBuilder: ((context, index) {
              return Column(
                children: usersScoreboard[index],
              );
            }),
          ),
        ),
        PageButton(
          handler1: () {
            setState(() {
              pageNum = (pageNum - 1) < 0 ? pageNum : (pageNum - 1);
            });
            controller.animateToPage(
              controller.page.toInt() - 1,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            );
          },
          handler2: () {
            setState(() {
              pageNum = (pageNum + 1) < ((widget.users.length ~/ nPages) + 1)
                  ? (pageNum + 1)
                  : pageNum;
            });
            controller.animateToPage(
              controller.page.toInt() + 1,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    this.handler1,
    this.handler2,
  });

  final handler1;
  final handler2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyButton(
          text: "Previous",
          buttonType: ButtonType.white,
          handler: this.handler1,
        ),
        SizedBox(
          width: 50,
        ),
        MyButton(
          text: "Next",
          buttonType: ButtonType.white,
          handler: this.handler2,
        ),
      ],
    );
  }
}
