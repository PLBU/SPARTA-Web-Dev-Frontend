import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';

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
    int nUsers = 50;
    List<dynamic> usersScoreboard = [];
    List<User> orderedUser = (widget.curUser != null)
      ? widget.users
          .where((element) => element.nim != widget.curUser.nim)
          .toList()
      : widget.users;
    if (widget.curUser != null) orderedUser.insert(0, widget.curUser);

    for (int i = 0; i <= orderedUser.length ~/ nUsers; i++) {
      if (i == orderedUser.length ~/ nUsers)
        usersScoreboard
          .add(orderedUser.sublist(i * nUsers, orderedUser.length).map(
            (entry) {
              return ScoreboardRow(
                id: (widget.ranks[entry.nim]).toString(),
                text: entry.nim + " " + entry.namaLengkap,
                nickname: entry.namaPanggilan,
                skor: entry.skor,
                bgColor: Colors.white,
                self: (widget.curUser != null && entry.nim == widget.curUser.nim),
              );
            },
          ).toList(),
        );
      else
        usersScoreboard
          .add(orderedUser.sublist(i * nUsers, (i + 1) * nUsers).map(
            (entry) {
              return ScoreboardRow(
                id: (widget.ranks[entry.nim]).toString(),
                text: entry.nim + " " + entry.namaLengkap,
                nickname: entry.namaPanggilan,
                skor: entry.skor,
                bgColor: Colors.white,
                self: (widget.curUser != null && entry.nim == widget.curUser.nim),
              );
            },
          ).toList(),
        );
    }

    return (widget.users.length>0) 
    ? Column(
      children: [
        PageButton(
          handler1: () {
            controller.animateToPage(
              controller.page.toInt() - 1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          handler2: () {
            controller.animateToPage(
              controller.page.toInt() + 1,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            );
          },
        ),
        Container(
          height: (deviceType == DeviceType.mobile)
              ? (usersScoreboard[pageNum % usersScoreboard.length].length) *
                  60.0
              : (usersScoreboard[pageNum % usersScoreboard.length].length) *
                  90.0,
          child: PageView.builder(
            onPageChanged: (pageID) {
              setState(() {
                pageNum = pageID;
              });
            },
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: (orderedUser.length ~/ nUsers) + 1,
            itemBuilder: ((context, index) {
              return Column(
                children: usersScoreboard[index],
              );
            }),
          ),
        ),
        PageButton(
          handler1: () {
            controller.animateToPage(
              controller.page.toInt() - 1,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            );
          },
          handler2: () {
            controller.animateToPage(
              controller.page.toInt() + 1,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    )
    : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "User tidak ditemukan!",
          style: TextStyle(
            fontFamily: "DrukWideBold",
            fontSize: (deviceType == DeviceType.mobile) ? 16 : 20,
          )
        )
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
