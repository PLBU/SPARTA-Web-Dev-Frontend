import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/user.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_button.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/pages/scoreboard/services/index.dart';
import 'package:sparta/pages/scoreboard/views/top_three.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard.dart';

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
      ranks = Map.fromIterable(allUser,
          key: (u) => u.nim, value: (u) => allUser.indexOf(u) + 1);
    });
  }

  void filterUsers({String jurusan, String nim, String name, String kelompok}) {
    setState(() {
      users = fetchUsers(jurusan, nim, name, kelompok);
    });
  }

  void configureSearch(String input) {
    var temp = {};
    if (input.indexOf('=') >= 0) {
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

    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: space * 2),
                    MyTitle(text: "SCOREBOARD", logo: "#"),
                    SizedBox(height: space),
                    TopThree(this.allUser[0], this.allUser[1], this.allUser[2]),
                    SizedBox(height: space),
                    SizedBox(height: space),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: MyTextField(
                        minLines: 1,
                        maxLines: 1,
                        hintText: "Cari..",
                        helperText:
                            "Dapat mencari dengan jurusan=IF; nama=test;",
                        width: (deviceType == DeviceType.mobile)
                            ? 350
                            : (deviceType == DeviceType.tablet)
                                ? 600
                                : 1000,
                        margin: (deviceType == DeviceType.mobile)
                            ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
                            : EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        controller: this.searchBarTEC,
                        submitHandler: (text) {
                          this.configureSearch(text);
                        },
                        prefixIcon: new IconButton(
                          padding: EdgeInsets.only(bottom: 1),
                          highlightColor: Colors.transparent,
                          icon: new Icon(Icons.search, size: respFont * 2),
                          onPressed: () {
                            this.configureSearch(this.searchBarTEC.text);
                          },
                          splashColor: Colors.transparent,
                        ),
                        suffixIcon: new IconButton(
                          padding: EdgeInsets.only(bottom: 1),
                          highlightColor: Colors.transparent,
                          icon: new Icon(Icons.clear, size: respFont * 2),
                          onPressed: () {
                            this.searchBarTEC.clear();
                          },
                          splashColor: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(height: space),
                    Scoreboard(users: snapshot.data, ranks: this.ranks),
                    SizedBox(height: space),
                  ],
                ),
              ],
            ),
          );
        }

        return new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black), //,
        );
      },
    );
  }
}
