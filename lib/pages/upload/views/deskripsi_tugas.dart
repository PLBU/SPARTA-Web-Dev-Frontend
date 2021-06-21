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
    String deadline =
        "Deadline: ${this.assignment.deadline.year.toString()}-${this.assignment.deadline.month.toString().padLeft(2, '0')}-${this.assignment.deadline.day.toString().padLeft(2, '0')}";

    DeviceType deviceType = UIUtils.getDeviceType(context);
    double respFont = (deviceType == DeviceType.mobile) ? 16 : 20;

    return Container(
      width: this.width,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(size),
      child: ListView(
        children: [
          Text(
            this.assignment.name,
            style: TextStyle(
              fontFamily: "DrukWideBold",
              fontSize: respFont,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            deadline,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: size),
          Text(
            this.assignment.spek,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: size,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
