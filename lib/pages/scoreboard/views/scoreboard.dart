import 'package:flutter/material.dart';
import 'package:sparta/pages/scoreboard/services/index.dart';
import 'package:sparta/pages/scoreboard/views/scoreboard_row.dart';
import 'package:sparta/models/user.dart';

class Scoreboard extends StatefulWidget {
  Scoreboard({Key key}) : super(key: key);

  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    _users = fetchUsers(null, null, null, null);
  }

  void filterUsers(
    String jurusan,
    String nim,
    String name,
    String kelompok,
  ) {
    setState(() {
      _users = fetchUsers(jurusan, nim, name, kelompok);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _users, // future data to listen for change
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data.asMap().entries.map((entry) {
              return ScoreboardRow(
                  id: (entry.key + 1).toString(),
                  text: entry.value.nim + " " + entry.value.name,
                  bgColor: entry.value.skor < 50 ? Colors.red : Colors.green,
                  self: false);
            }).toList(),
          );
        }
        return new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black), //,
        );
      },
    );
  }
}
