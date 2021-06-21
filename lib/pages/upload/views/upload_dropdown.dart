import 'package:flutter/material.dart';
import 'package:sparta/models/assignment.dart';

class UploadDropdown extends StatelessWidget {
  const UploadDropdown({
    this.width,
    this.onChange,
    this.value,
    this.items,
    this.size,
  });

  final width;
  final onChange;
  final value;
  final List<Assignment> items;
  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      child: Row(
        children: [
          Text(
            "Pilih Tugas:",
            style: TextStyle(fontSize: size),
          ),
          SizedBox(width: 10),
          DropdownButton(
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: size,
            ),
            value: this.value,
            onChanged: this.onChange,
            items: this.items.map(
              (Assignment assingment) {
                return DropdownMenuItem<String>(
                  value: assingment.id,
                  child: Text(assingment.name),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
