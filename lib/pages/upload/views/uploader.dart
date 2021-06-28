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
    this.jwtToken,
    this.data,
  });

  final jwtToken;
  final List<dynamic> data;

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  List<Assignment> assignments;
  List<Submission> submissions;
  List<Assignment> unfinished;
  FileType pickingType = FileType.any;

  String _idTugas;
  Assignment _curAssignment;
  Submission _curSubmission;
  bool _submitted;
  List<PlatformFile> _paths;
  String _fileName;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _paths = null;
    _fileName = null;
    assignments = widget.data[0];
    submissions = widget.data[1];
    unfinished = widget.data[2];

    _idTugas = assignments.length > 0 ? assignments.first.id : null;
    _curAssignment = assignments.length > 0 ? assignments.first : null;
    _submitted = !unfinished.contains(_curAssignment);
    _curSubmission = _submitted && assignments.length > 0
        ? submissions.firstWhere((element) => element.assignment == _idTugas)
        : null;
    inspect(_curAssignment);
  }

  void _openFileExplorer() async {
    try {
      var temp = await FilePicker.platform.pickFiles(
        type: pickingType,
        allowMultiple: false,
        allowedExtensions: null,
      );
      _paths = temp != null ? temp.files : null;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _fileName = _paths != null
          ? _paths
              .map((e) => e.name)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", "")
          : 'Pilih File..';
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

    return MyContainer(
      padding: EdgeInsets.all((deviceType == DeviceType.mobile) ? 25 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UploadDropdown(
            width: respWidth,
            onChange: (dynamic newValue) {
              setState(() {
                this._idTugas = newValue;
                this._curAssignment =
                    assignments.firstWhere((el) => el.id == newValue);
                this._submitted = !unfinished.contains(_curAssignment);
                this._curSubmission = _submitted
                    ? submissions
                        .firstWhere((element) => element.assignment == _idTugas)
                    : null;
                this._paths = null;
                this._fileName = 'Pilih File..';
              });
            },
            value: this._idTugas,
            items: assignments,
          ),
          SizedBox(height: 10),
          DeskripsiTugas(
            assignment: _curAssignment,
            width: respWidth,
            size: respFont,
          ),
          SizedBox(height: 20),
          if (this.assignments.length > 0)
          UploadButton(
            width: respWidth,
            fileHandler: () {
              _openFileExplorer();
            },
            fileName: this._fileName,
            submitted: this._submitted,
            submission: this._curSubmission,
            loading: this._loading,
            submitHandler: () async {
              if (_loading) return;
              if (_submitted)
                setState(() {
                  _submitted = false;
                  _paths = null;
                });
              else if (_paths != null) {
                setState(() {
                  unfinished.remove(_curAssignment);
                  _curSubmission = null;
                  _submitted = true;
                  _loading = true;
                });

                var res = await uploadFile(
                  _paths.first.bytes,
                  _paths.first.name,
                  widget.jwtToken,
                  _idTugas,
                );

                if (res == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Upload Berhasil!")));
                  var temp = await fetchSubmissions(widget.jwtToken);
                  setState(() {
                    _loading = false;
                    submissions = temp;
                    _curSubmission = submissions.firstWhere(
                        (element) => element.assignment == _idTugas);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Upload gagal, silahkan coba kembali")));
                  setState(() {
                    _loading = false;
                    _submitted = false;
                    _paths = null;
                    _fileName = null;
                  });
                }
              } else
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Pilih File yang ingin di upload terlebih dahulu!")));
            },
          ),
        ],
      ),
    );
  }
}
