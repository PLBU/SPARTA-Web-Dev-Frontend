import 'package:flutter/material.dart';

import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_card.dart';

class InfoSparta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double objectSpacing = 40;
    
    return Container(
      child: Column(
        children: [
          MyTitle(text: "SPARTA",logo: "?"),
          SizedBox(height: objectSpacing),
          MyCard(
            content: "SPARTA (Simulasi dan Pelatihan Keorganisasian Untuk Anggota) merupakan kaderisasi tahap awal pada rangkaian masa orientasi anggota baru Himpunan Mahasiswa Informatika ITB. SPARTA bertujuan untuk memberikan pengenalan dan pembekalan yang esensial terkait himpunan dan berhimpun serta pemenuhan profil-profil keanggotaan pada masa orientasi.",
            image: Image.asset("assets/images/sparta2020.png",width: 100, height: 100,),
            title: "APA ITU SPARTA?",
            type: CardType.Right,
            ),
        ],
      )
    );
  }
}