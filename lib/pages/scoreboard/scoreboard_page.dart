import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<List<User>> users;
  List<User> allUser;
  Map<String, int> ranks;
  final searchBarTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    users = fetchUsers(null, null, null, null);

    users.then((allUser) {
      this.allUser = allUser;
      // inspect(allUser);

      print("test1");
      configureRanks(allUser);
      print("test3");
      inspect(ranks);

      // ranks = Map.fromIterable(allUser,
      //     key: (u) => u.nim, value: (u) => allUser.indexOf(u) + 1);
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

    ranks = Map.fromIterable(users,
      key: (u) => u.nim, value: (u){
        if (prevScore != null && prevScore!=u.skor) curRank = idx;
        prevScore=u.skor;
        idx++;
        return curRank;
      },
    );

    // for (User user in users) {
    //   inspect(user);
    //   if (prevScore != null && prevScore != user.skor) curRank = idx;
    //   this.ranks[user.nim] = curRank;
    //   prevScore = user.skor;
    //   idx++;
    // }
    inspect(ranks);
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double space = (deviceType == DeviceType.mobile)
        ? 10
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

      return FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: space * 2),
                      MyTitle(text: "SCOREBOARD", logo: "#"),
                      SizedBox(height: space),
                      TopThree(
                        this.allUser[0],
                        this.allUser[1],
                        this.allUser[2],
                      ),
                      SizedBox(height: space),
                      SizedBox(height: space),
                      ScoreboardSearch(
                        submitHandler: configureSearch,
                        searchBarTEC: searchBarTEC,
                        respFont: respFont,
                      ),
                      SizedBox(height: space),
                      Scoreboard(
                        users: snapshot.data,
                        ranks: this.ranks,
                        curUser: currentUser,
                      ),
                      SizedBox(height: space),
                    ],
                  ),
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
