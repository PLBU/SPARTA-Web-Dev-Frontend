import 'package:flutter/material.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_card.dart';

class InfoHMIF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double objectSpacing = 40;

    final contents = [
      TextSpan(text: 'HMIF', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: ' adalah Himpunan Mahasiswa Informatika\n',
        children: [
          TextSpan(
              text: 'Visi: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: 'HMIF sebagai Katalisator Karya dalam Harmoni\n',
            children: [
              TextSpan(
                  text: 'Misi:\n', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text:'''\u2022Optimalisasi potensi warga HMIF berdasarkan minat dan bakat dari warganya
\u2022Mengembangkan wadah untuk berkarya sebagai bentuk aktualisasi diri yang berasaskan profesionalitas
\u2022Membangun rumah aspirasi dengan berlandaskan empati''',
              )
            ],
          ),
        ],
      ),
    ];

    return Container(
        child: Column(
      children: [
        MyTitle(text: "HMIF ITB", logo: "?"),
        SizedBox(height: objectSpacing),
        MyCard(
          textSpan: contents,
          image: Image.asset("assets/images/hmif.png", width: 176),
          title: "APA ITU HMIF ITB?",
          type: CardType.Right,
        )
      ],
    ));
  }
}
