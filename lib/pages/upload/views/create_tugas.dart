import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_container.dart';
import 'package:sparta/widgets/my_text_field.dart';
import 'package:sparta/pages/upload/services/index.dart';
import 'package:sparta/pages/upload/views/deadline_input.dart';
import 'package:sparta/pages/upload/views/filter_input.dart';

class CreateTugas extends StatefulWidget {
  CreateTugas({this.token});

  final token;

  @override
  _CreateTugasState createState() => _CreateTugasState();
}

class _CreateTugasState extends State<CreateTugas> {
  bool _uploading = false;
  DateTime _deadlineDate = DateTime.now();
  TimeOfDay _deadlineTime = TimeOfDay.now();
  String _dateString;
  String _timeString;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController spekTEC = TextEditingController();
  TextEditingController upperBoundTEC = TextEditingController();
  TextEditingController lowerBoundTEC = TextEditingController();
  TextEditingController nimTEC = TextEditingController();
  TextEditingController kelompokTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateString =
        "${_deadlineDate.day.toString()}/${_deadlineDate.month.toString().padLeft(2, '0')}/${_deadlineDate.year.toString().padLeft(2, '0')}";
    _timeString =
        "${_deadlineTime.hour.toString().padLeft(2, '0')}:${_deadlineTime.minute.toString().padLeft(2, '0')}";
  }

  String formatDeadline(DateTime date, TimeOfDay time) {
    var dateStr =
        "${_deadlineDate.year.toString()}-${_deadlineDate.month.toString().padLeft(2, '0')}-${_deadlineDate.day.toString().padLeft(2, '0')}";
    var timeStr =
        "T${_deadlineTime.hour.toString().padLeft(2, '0')}:${_deadlineTime.minute.toString().padLeft(2, '0')}:00";

    return dateStr + timeStr;
  }

  void reset() {
    nameTEC.clear();
    spekTEC.clear();
    upperBoundTEC.clear();
    lowerBoundTEC.clear();
    nimTEC.clear();
    kelompokTEC.clear();
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double respWidth = (deviceType == DeviceType.mobile)
        ? 300
        : (deviceType == DeviceType.tablet)
            ? 450
            : 700;
    double respFont = (deviceType == DeviceType.mobile)
        ? 12
        : (deviceType == DeviceType.tablet)
            ? 14
            : 16;

    return MyContainer(
      padding: EdgeInsets.all((deviceType == DeviceType.mobile) ? 25 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Judul Tugas:",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: respFont,
            ),
          ),
          MyTextField(
            width: respWidth,
            controller: nameTEC,
          ),
          Text(
            "Deskripsi:",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: respFont,
            ),
          ),
          Container(
            width: respWidth,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 20),
            child: TextField(
              controller: spekTEC,
              maxLines: null,
              cursorColor: Colors.black,
              style: TextStyle(
                fontFamily: "Roboto",
                // fontSize: respFont,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusColor: Colors.black,
              ),
            ),
          ),
          DeadlineInput(
            width: respWidth,
            fontSize: respFont,
            dateString: this._dateString,
            timeString: this._timeString,
            dateHandler: () async {
              var temp = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.utc(2022, 7, 31),
                initialDate: DateTime.now(),
              );

              if (temp != null)
                setState(() {
                  _deadlineDate = temp;
                  _dateString =
                      "${_deadlineDate.day.toString()}/${_deadlineDate.month.toString().padLeft(2, '0')}/${_deadlineDate.year.toString().padLeft(2, '0')}";
                });
            },
            timeHandler: () async {
              var temp = await showTimePicker(
                context: context,
                initialTime: _deadlineTime,
              );

              if (temp != null)
                setState(() {
                  _deadlineTime = temp;
                  _timeString =
                      "${_deadlineTime.hour.toString().padLeft(2, '0')}:${_deadlineTime.minute.toString().padLeft(2, '0')}";
                });
            },
          ),
          FilterInput(
            width: respWidth,
            fontSize: respFont,
            upperBoundTEC: upperBoundTEC,
            lowerBoundTEC: lowerBoundTEC,
            nimTEC: nimTEC,
            kelompokTEC: kelompokTEC,
            submitHandler: () async {
              setState(() {
                _uploading = true;
              });
              
              var res;
              if (nameTEC.text != "" || spekTEC.text != "")
                res = await uploadTugas({
                  'name': nameTEC.text,
                  'spek': spekTEC.text,
                  'upperScore':
                      upperBoundTEC.text == "" ? null : int.parse(upperBoundTEC.text),
                  'lowerScore':
                      lowerBoundTEC.text == "" ? null : int.parse(lowerBoundTEC.text),
                  'nim': nimTEC.text == ""
                      ? null
                      : nimTEC.text.replaceAll(" ", "").split(","),
                  'kelompok': kelompokTEC.text == "" ? null : int.parse(kelompokTEC.text),
                  'deadline':
                      formatDeadline(this._deadlineDate, this._deadlineTime),
                }, widget.token);

              setState(() {
                _uploading = false;
              });
              if (res == 200) reset();
            },
            uploadingState: this._uploading,
            isDesktop: !(deviceType == DeviceType.mobile) &&
                !(deviceType == DeviceType.tablet),
          )
        ],
      ),
    );
  }
}
