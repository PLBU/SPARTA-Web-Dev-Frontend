import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';

const userPerPage = 5;

class ScoreboardView extends StatefulWidget {
  ScoreboardView({this.users, this.ranks, this.curUser});

  final List<User> users;
  final Map<String, int> ranks;
  final User curUser;

  @override
  _ScoreboardViewState createState() => _ScoreboardViewState();
}

class _ScoreboardViewState extends State<ScoreboardView> {
  List<dynamic> usersScoreboard;
  int _pageNum;
  bool _next = false, _prev = false;

  @override
  void initState() {
    super.initState();
    _pageNum = 0;

    int nUsers = userPerPage;
    List<dynamic> tempArr = [];
    List<User> orderedUser = (widget.curUser != null)
        ? widget.users
            .where((element) => element.nim != widget.curUser.nim)
            .toList()
        : widget.users;
    if (widget.curUser != null && orderedUser.length<widget.users.length) 
      orderedUser.insert(0, widget.curUser);

    for (int i = 0; i <= orderedUser.length ~/ nUsers; i++) {
      if (i == orderedUser.length ~/ nUsers) {
        if (orderedUser.length % nUsers > 0)
          tempArr.add(
            orderedUser.sublist(i * nUsers, orderedUser.length).map(
              (entry) {
                return ScoreboardRow(
                  objectId: entry.id,
                  id: (widget.ranks[entry.nim]).toString(),
                  text: entry.nim + " " + entry.namaLengkap,
                  nickname: entry.namaPanggilan,
                  skor: entry.skor,
                  bgColor: Colors.white,
                  self: (widget.curUser != null &&
                      entry.nim == widget.curUser.nim),
                );
              },
            ).toList(),
          );
        else
          continue;
      } else
        tempArr.add(
          orderedUser.sublist(i * nUsers, (i + 1) * nUsers).map(
            (entry) {
              return ScoreboardRow(
                objectId: entry.id,
                id: (widget.ranks[entry.nim]).toString(),
                text: entry.nim + " " + entry.namaLengkap,
                nickname: entry.namaPanggilan,
                skor: entry.skor,
                bgColor: Colors.white,
                self:
                    (widget.curUser != null && entry.nim == widget.curUser.nim),
              );
            },
          ).toList(),
        );
    }

    usersScoreboard = tempArr;
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    final PageController controller = PageController(initialPage: 0);

    setState(() {
      _next = (_pageNum + 1) % usersScoreboard.length > 0;
      _prev = _pageNum % usersScoreboard.length > 0;
    });

    return (widget.users.length > 0)
        ? Column(
            children: [
              PageButton(
                next: _next,
                prev: _prev,
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
                    ? (usersScoreboard[_pageNum % usersScoreboard.length]
                            .length) *
                        60.0
                    : (usersScoreboard[_pageNum % usersScoreboard.length]
                            .length) *
                        90.0,
                child: PageView.builder(
                  onPageChanged: (pageID) {
                    setState(() {
                      _pageNum = pageID;
                    });
                  },
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.users.length % userPerPage > 0
                      ? (widget.users.length ~/ userPerPage) + 1
                      : (widget.users.length ~/ userPerPage),
                  itemBuilder: ((context, index) {
                    return Column(
                      children: usersScoreboard[index],
                    );
                  }),
                ),
              ),
              PageButton(
                next: _next,
                prev: _prev,
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
              Text("User tidak ditemukan!",
                  style: TextStyle(
                    fontFamily: "DrukWideBold",
                    fontSize: (deviceType == DeviceType.mobile) ? 16 : 20,
                  ))
            ],
          );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    this.handler1,
    this.handler2,
    this.next,
    this.prev,
  });

  final handler1;
  final handler2;
  final next;
  final prev;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    return Container(
      width: (deviceType == DeviceType.mobile)
          ? 350
          : (deviceType == DeviceType.tablet)
              ? 600
              : 1000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (prev)
            MyButton(
              text: "PREV PAGE",
              buttonType: ButtonType.white,
              handler: this.handler1,
            ),
          SizedBox(
            width: 50,
          ),
          if (next)
            MyButton(
              text: "NEXT PAGE",
              buttonType: ButtonType.white,
              handler: this.handler2,
            ),
        ],
      ),
    );
  }
}
