import 'package:flutter/material.dart';

import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_card.dart';

class InfoHMIF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double objectSpacing = 40;
    
    return Container(
      child: Column(
        children: [
          MyTitle(text: "HMIF ITB",logo: "?"),
          SizedBox(height: objectSpacing),
          MyCard(
            content: '''HMIF adalah Himpunan Mahasiswa Informatika
Visi: HMIF sebagai Katalisator Karya dalam Harmoni
Misi:
-Optimalisasi potensi warga HMIF berdasarkan minat dan bakat dari warganya
-Mengembangkan wadah untuk berkarya sebagai bentuk aktualisasi diri yang berasaskan profesionalitas
-Membangun rumah aspirasi dengan berlandaskan empati''',
            image: Image.asset("assets/images/hmif.png",width: 100,height: 100,),
            title: "APA ITU HMIF ITB?",
            type: CardType.Right,)
        ],
      )
    );
  }
}