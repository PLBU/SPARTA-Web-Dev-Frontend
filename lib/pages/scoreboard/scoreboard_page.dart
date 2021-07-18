import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparta/pages/scoreboard/views/score_input.dart';
import 'package:sparta/provider/auth_state.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/pages/scoreboard/services/index.dart';
import 'package:sparta/pages/scoreboard/views/top_three.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_search.dart';

class ScoreboardPage extends StatefulWidget {
  ScoreboardPage();

  @override
  _ScoreboardPageState createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  Future<List<dynamic>> users;
  List<User> allUser;
  List<User> topThree;
  Map<String, int> ranks;
  final searchBarTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    users = fetchUsers(null, null, null, null);

    users.then((allUser) {
      setState(() {
        topThree = [allUser[0], allUser[1], allUser[2]];
      });

      this.allUser = allUser;

      configureRanks(allUser);
    });
  }

  void filterUsers({String jurusan, String nim, String name, String kelompok}) {
    setState(() {
      users = fetchUsers(jurusan, nim, name, kelompok);
    });
  }

  void configureSearch(String input) {
    var temp = {};
    if (input != null && input.indexOf('=') >= 0) {
      input = input.replaceAll(" ", "");
      var filters = input.split(';');
      for (var filter in filters) {
        if (filter.length == 0) continue;

        var values = filter.split('=');
        temp[values[0] == "nama" ? "name" : values[0]] = values[1];
      }
    } else {
      temp["name"] = input;
    }

    filterUsers(
      jurusan: temp["jurusan"],
      name: temp["name"],
      nim: temp["nim"],
      kelompok: temp["kelompok"],
    );
  }

  void configureRanks(List<User> users) {
    int curRank = 1, idx = 1;
    int prevScore;

    ranks = Map.fromIterable(
      users,
      key: (u) => u.nim,
      value: (u) {
        if (prevScore != null && prevScore != u.skor) curRank = idx;
        prevScore = u.skor;
        idx++;
        return curRank;
      },
    );
  }

  void editBulkScore(
    String kelFilter,
    String nimFilter,
    String skor,
    String jwt,
    BuildContext context,
  ) async {
    bool success;
    int score = int.tryParse(skor);
    List<int> kel = [];
    List<String> nim = [];

    if (kelFilter != null && kelFilter != "") {
      print("masuk kel");
      kelFilter = kelFilter.replaceAll(" ", "");
      var groups = (kelFilter.indexOf(';') >= 0)
          ? kelFilter.split(';')
          : (kelFilter.indexOf('\n') >= 0)
              ? kelFilter.split('\n')
              : [kelFilter];
      for (var item in groups) {
        if (item != "") kel.add(int.tryParse(item.replaceAll(";\n", "")));
      }
    } else
      kel = null;

    if (nimFilter != null && nimFilter != "") {
      nimFilter = nimFilter.replaceAll(" ", "");
      var groups = (nimFilter.indexOf(';') >= 0)
          ? nimFilter.split(';')
          : (nimFilter.indexOf('\n') >= 0)
              ? nimFilter.split('\n')
              : [nimFilter];
      for (var item in groups) {
        if (item != "") nim.add(item.replaceAll(";\n", ""));
      }
    } else
      nim = null;

    if (score != null) {
      success = await updateBulkScores(score, kel, nim, jwt);
    } else {
      success = false;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: success
            ? Text('Score updated!')
            : Text('Error, fail to update score!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 15
        : (deviceType == DeviceType.tablet)
            ? 20
            : 40;
    double respFont = (deviceType == DeviceType.mobile)
        ? 10
        : (deviceType == DeviceType.tablet)
            ? 13
            : 16;

    return Consumer(builder: (context, watch, child) {
      final currentUser = watch(AuthState.currentUser).state;
      final type = watch(AuthState.type).state;
      final jwt = watch(AuthState.jwt).state;

      return FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: space),
                  MyTitle(text: "SCOREBOARD", logo: "#"),
                  SizedBox(height: space * 1.5),
                  if (topThree != null)
                    TopThree(
                      this.topThree[0],
                      this.topThree[1],
                      this.topThree[2],
                    )
                  else
                    TopThree(
                      snapshot.data[0],
                      snapshot.data[1],
                      snapshot.data[2],
                    ),
                  SizedBox(height: space * 1.5),
                  ScoreboardSearch(
                    submitHandler: configureSearch,
                    searchBarTEC: searchBarTEC,
                    respFont: respFont,
                    connectionState: snapshot.connectionState,
                  ),
                  if (type == 'admin') SizedBox(height: space * 1.5),
                  if (type == 'admin')
                    ScoreInput(
                      jwt: jwt,
                      editBulkScore: editBulkScore,
                    ),
                  SizedBox(height: space * 1.5),
                  if (snapshot.connectionState == ConnectionState.done)
                    ScoreboardView(
                      users: snapshot.data,
                      ranks: this.ranks,
                      curUser: currentUser,
                    ),
                  SizedBox(height: space),
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black), //,
            ),
          );
        },
      );
    });
  }
}
