import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/models/user.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({this.users, this.ranks, this.curUser});

  final List<User> users;
  final Map<String, int> ranks;
  final User curUser;

  @override
  Widget build(BuildContext context) {
    var usersScoreboard = curUser != null
        ? this
            .users
            .where((user) => user.nim != curUser.nim)
            .toList()
            .map((entry) {
            return ScoreboardRow(
              id: (ranks[entry.nim]).toString(),
              text: entry.nim + " " + entry.namaLengkap,
              nickname: entry.namaPanggilan,
              skor: entry.skor,
              bgColor:
                  Colors.white, //entry.skor < 50 ? Colors.red : Colors.green,
              self: false,
            );
          }).toList()
        : this.users.map((entry) {
            return ScoreboardRow(
              id: (ranks[entry.nim]).toString(),
              text: entry.nim + " " + entry.namaLengkap,
              nickname: entry.namaPanggilan,
              skor: entry.skor,
              bgColor:
                  Colors.white, //entry.skor < 50 ? Colors.red : Colors.green,
              self: false,
            );
          }).toList();

    if (curUser != null)
      usersScoreboard.insert(
          0,
          ScoreboardRow(
            id: ranks[curUser.nim].toString(),
            text: curUser.nim + " " + curUser.namaLengkap,
            skor: curUser.skor,
            self: true,
          ));

    return Column(
      children: usersScoreboard,
    );
  }
}
