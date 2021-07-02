import 'package:flutter/material.dart';

import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_card.dart';

class InfoSparta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double objectSpacing = 40;

    final contents = [
      TextSpan(text: 'SPARTA ', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: '(Simulasi dan Pelatihan Keorganisasian Untuk Anggota) merupakan kaderisasi tahap awal pada rangkaian masa orientasi anggota baru'),
      TextSpan(text: ' Himpunan Mahasiswa Informatika ITB.\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'SPARTA ', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'bertujuan untuk memberikan pengenalan dan pembekalan yang esensial terkait himpunan dan berhimpun serta pemenuhan profil-profil keanggotaan pada masa orientasi.'),
    ];
    
    return Container(
      child: Column(
        children: [
          MyTitle(text: "SPARTA",logo: "?"),
          SizedBox(height: objectSpacing),
          MyCard(
            textSpan: contents,
            image: Image.asset("assets/images/sparta2020.png",width: 128),
            title: "APA ITU SPARTA?",
            type: CardType.Right,
            ),
        ],
      )
    );
  }
}