import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

import 'package:sparta/pages/home/views/divisi.dart';

import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_heading_text.dart';

class Departemen extends StatelessWidget {
  const Departemen({
    this.namaDepartemen,
    this.namaKetua,
    this.textSpan,
    this.foto,
    this.divisi,
  });

  final String namaDepartemen;
  final String namaKetua;
  final List<TextSpan> textSpan;
  final List<Divisi> divisi;
  final Image foto;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double objectSpacing = 40;
    return Container(
      child: Column(
        children: [
          MyHeadingText(content: namaDepartemen),
          SizedBox(height: objectSpacing),
          MyCard(
            textSpan: textSpan,
            image: foto,
            title: "KEPALA DEPT.",
            type: CardType.Bottom,
            height: (deviceType == DeviceType.mobile)
                ? 190
                : (deviceType == DeviceType.tablet)
                    ? 250
                    : 330,
          ),
          for (Divisi i in divisi)
            Column(
              children: [
                SizedBox(height: objectSpacing),
                i,
              ],
            ),
        ],
      ),
    );
  }
}
