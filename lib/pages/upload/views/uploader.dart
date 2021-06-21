import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/assignment.dart';
import 'package:sparta/pages/upload/services/index.dart';
import 'package:sparta/pages/upload/views/deskripsi_tugas.dart';
import 'package:sparta/pages/upload/views/upload_dropdown.dart';
import 'dart:html';

class Uploader extends StatefulWidget {
  Uploader({this.user, this.jwtToken});

  final user;
  final jwtToken;

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  String tugas;
  Assignment curAssignment;
  Future<List<Assignment>> assignments;

  @override
  void initState() {
    super.initState();
    assignments = fetchAssignments(widget.jwtToken);
    assignments.then((list) {
      tugas = list[0].id;
      curAssignment = list.firstWhere((el) => el.id == list[0].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double respWidth = (deviceType == DeviceType.mobile)
        ? 300
        : (deviceType == DeviceType.tablet)
            ? 450
            : 700;
    double respFont = (deviceType == DeviceType.mobile) ? 14 : 18;

    return FutureBuilder(
      future: assignments,
      builder: (context, AsyncSnapshot<List<Assignment>> snapshot) {
        if (snapshot.hasData)
          return Container(
            width: (deviceType == DeviceType.mobile)
                ? 350
                : (deviceType == DeviceType.tablet)
                    ? 550
                    : 800,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UploadDropdown(
                  width: respWidth,
                  onChange: (dynamic newValue) {
                    setState(() {
                      tugas = newValue;
                      curAssignment =
                          snapshot.data.firstWhere((el) => el.id == newValue);
                    });
                  },
                  value: tugas,
                  items: snapshot.data,
                ),
                DeskripsiTugas(
                  assignment: curAssignment,
                  width: respWidth,
                  size: respFont,
                ),
              ],
            ),
          );

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        );
      },
    );
  }
}
