import 'package:flutter/material.dart';

class DeadlineInput extends StatelessWidget {
  const DeadlineInput({
    this.dateHandler,
    this.timeHandler,
    this.dateString,
    this.timeString,
    this.width,
    this.fontSize,
  });

  final dateHandler;
  final timeHandler;
  final dateString;
  final timeString;
  final width;
  final fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Deadline:",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: this.fontSize,
          ),
        ),
        Container(
          width: width,
          child: Row(
            children: [
              Container(
                width: this.width * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      this.dateString,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: this.fontSize,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today_rounded),
                      onPressed: this.dateHandler,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: this.width * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      this.timeString,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: this.fontSize,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time_outlined),
                      onPressed: this.timeHandler,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
