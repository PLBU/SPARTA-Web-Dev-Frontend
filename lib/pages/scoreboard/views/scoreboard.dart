import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/models/user.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({this.users, this.ranks});

  final List<User> users;
  final Map<String, int> ranks;

  @override
  Widget build(BuildContext context) {
    var usersScoreboard = this.users.asMap().entries.map((entry) {
      // if (entry.value.nim!=currentUser.nim)
      return ScoreboardRow(
        id: (ranks[entry.value.nim]).toString(),
        text: entry.value.skor.toString() +
            " - " +
            entry.value.nim +
            " " +
            entry.value.namaLengkap,
        nickname: entry.value.namaPanggilan,
        bgColor: entry.value.skor < 50 ? Colors.red : Colors.green,
        self: false,
      );
    }).toList();

    // usersScoreboard.insert(0, currentUser)

    return Column(
      children: usersScoreboard,
    );
  }
}
