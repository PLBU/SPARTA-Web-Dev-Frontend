import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
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
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Container(
      width: this.width,
      child: Row(
        children: [
          Text(
            "Pilih Tugas:",
            style: TextStyle(
              fontSize: size,
              fontFamily: "Roboto",
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 35,
            width: (deviceType == DeviceType.mobile) ? 180 : 300,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: this.items.length > 0
                ? DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
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
                              child: Text(
                                assingment.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "Tidak ada tugas yang tersedia",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: size,
                        color: Colors.black,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
