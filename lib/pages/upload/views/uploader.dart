import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/models/assignment.dart';
import 'package:sparta/models/submission.dart';
import 'package:sparta/pages/upload/services/index.dart';
import 'package:sparta/pages/upload/views/deskripsi_tugas.dart';
import 'package:sparta/pages/upload/views/upload_dropdown.dart';
import 'package:sparta/pages/upload/views/upload_button.dart';
import 'package:sparta/widgets/my_container.dart';

class Uploader extends StatefulWidget {
  Uploader({
    this.user,
    this.jwtToken,
    this.data,
  });

  final user;
  final jwtToken;
  List<dynamic> data;

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  List<Assignment> assignments;
  List<Submission> submissions;
  List<Assignment> unfinished;

  String _tugas;
  Assignment _curAssignment;
  Submission _curSubmission;
  bool _submitted;
  List<PlatformFile> _paths;
  String _extension;
  String _fileName;
  bool _loadingPath = false;
  FileType _pickingType = FileType.any;

  @override
  void initState() {
    super.initState();
    assignments = widget.data[0];
    submissions = widget.data[1];
    unfinished = widget.data[2];

    _tugas = assignments.first.id;
    _curAssignment = assignments.first;
    _submitted = !unfinished.contains(_curAssignment);
    _curSubmission = _submitted
        ? submissions.firstWhere((element) => element.assignment == _tugas)
        : null;
    inspect(_curAssignment);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        allowedExtensions: null,
      ))
          .files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null
          ? _paths
              .map((e) => e.name)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", "")
          : 'Pilih File..';
    });
    inspect(_paths);
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

    return MyContainer(
      width: (deviceType == DeviceType.mobile)
          ? 350
          : (deviceType == DeviceType.tablet)
              ? 550
              : 800,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UploadDropdown(
            width: respWidth,
            onChange: (dynamic newValue) {
              setState(() {
                this._tugas = newValue;
                this._curAssignment =
                    assignments.firstWhere((el) => el.id == newValue);
                this._submitted = !unfinished.contains(_curAssignment);
                this._curSubmission = _submitted
                    ? submissions
                        .firstWhere((element) => element.assignment == _tugas)
                    : null;
                this._paths = null;
                this._fileName = 'Pilih File..';
              });
            },
            value: this._tugas,
            items: assignments,
          ),
          SizedBox(height: 10),
          DeskripsiTugas(
            assignment: _curAssignment,
            width: respWidth,
            size: respFont,
          ),
          SizedBox(height: 20),
          UploadButton(
            width: respWidth,
            fileHandler: () {
              _openFileExplorer();
            },
            fileName: this._fileName,
            submitted: this._submitted,
            submission: this._curSubmission,
            submitHandler: () async {
              if (_submitted) {
                setState(() {
                  _submitted = false;
                  _paths = null;
                });
              } else if (_paths != null)
                await uploadFile(
                  _paths.first.bytes,
                  _paths.first.name,
                  widget.jwtToken,
                  _curAssignment.id,
                );
              else
                setState(() {
                  _fileName = "Pilih File terlebih dahulu!";
                });
            },
          ),
        ],
      ),
    );
  }
}
