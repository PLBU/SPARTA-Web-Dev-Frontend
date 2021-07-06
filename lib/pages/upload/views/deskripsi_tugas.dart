import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

class DeskripsiTugas extends StatelessWidget {
  const DeskripsiTugas({
    this.assignment,
    this.width,
    this.size,
  });

  final assignment;
  final width;
  final size;

  @override
  Widget build(BuildContext context) {
    String date;
    String time;
    if (this.assignment != null) {
      date =
          "Deadline: ${this.assignment.deadline.year.toString()}-${this.assignment.deadline.month.toString().padLeft(2, '0')}-${this.assignment.deadline.day.toString().padLeft(2, '0')}";
      time =
          "${this.assignment.deadline.hour.toString().padLeft(2, '0')}:${this.assignment.deadline.minute.toString().padLeft(2, '0')}:${this.assignment.deadline.second.toString().padLeft(2, '0')}";
    }

    DeviceType deviceType = UIUtils.getDeviceType(context);
    double respFont = (deviceType == DeviceType.mobile) ? 16 : 20;

    return Container(
      width: this.width,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(size),
      child: this.assignment != null
          ? ListView(
              children: [
                SelectableText(
                  this.assignment.name,
                  style: TextStyle(
                    fontFamily: "DrukWideBold",
                    fontSize: respFont * 1.2,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: size * 0.5),
                SelectableText(
                  date + " " + time,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: size,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: size),
                SelectableText(
                  this.assignment.spek,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: size,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            )
          : Center(
              child: Text(
              "Selamat Liburan :)",
              style: TextStyle(
                fontFamily: "DrukWideBold",
                fontSize: respFont * 2,
                color: Colors.black
              ),
            )),
    );
  }
}
