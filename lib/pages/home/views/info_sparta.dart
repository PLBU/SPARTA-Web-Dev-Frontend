import 'package:flutter/material.dart';

import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/utils/ui_utils.dart';

class InfoSparta extends StatefulWidget {
  @override
  _InfoSpartaState createState() => _InfoSpartaState();
}

class _InfoSpartaState extends State<InfoSparta> {
  bool second = false;
  int _pageNum = 0;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double objectSpacing = 40;
    final PageController controller = PageController(initialPage: 0);

    final contents = [
      [
        TextSpan(
            text: 'SPARTA ', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text:
                '(Simulasi dan Pelatihan Keorganisasian Untuk Anggota) merupakan kaderisasi tahap awal pada rangkaian masa orientasi anggota baru'),
        TextSpan(
            text: ' Himpunan Mahasiswa Informatika ITB.\n\n',
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text: 'SPARTA ', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text:
                'bertujuan untuk memberikan pengenalan dan pembekalan yang esensial terkait himpunan dan berhimpun serta pemenuhan profil-profil keanggotaan pada masa orientasi.'),
      ],
      [
        TextSpan(text: 'Visi\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text:
                'Mewujudkan SPARTA HMIF ITB 2020 sebagai wadah pembangkit semangat berkontribusi berlandaskan rasa empati demi mencapai tujuan HMIF ITB\n\n'),
        TextSpan(text: 'Misi\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text:
                '1. Memberikan arahan untuk mengenali diri sendiri lebih dalam dan memetakan langkah diri dengan berpegang teguh terhadap idealismenya\n'),
        TextSpan(
            text:
                '2. Menginisiasi dan membangun rasa kekeluargaan terhadap warga HMIF berlandaskan rasa empati\n'),
        TextSpan(
            text:
                '3. Mengenalkan organisasi HMIF ITB sebagai wadah untuk berkembang dan berkontribusi beserta urgensi dalam berorganisasi\n'),
        TextSpan(
            text:
                '4. Menanamkan semangat untuk berkontribusi dan memberikan manfaat kepada lingkungan sekitar berlandaskan rasa empati\n'),
        TextSpan(text: '5. Mengamalkan budaya apresiasi dalam rangkaian acara'),
      ]
    ];

    final cards = [
      MyCard(
        textSpan: contents[0],
        image: Image.asset("assets/images/sparta2020.png", width: 128),
        title: "APA ITU SPARTA?",
        type: CardType.Right,
      ),
      MyCard(
        textSpan: contents[1],
        image: null,
        title: "APA ITU SPARTA?",
        type: CardType.Right,
      ),
    ];

    List<double> heights = [
      (deviceType == DeviceType.mobile)
          ? 470
          : (deviceType == DeviceType.tablet)
              ? 360
              : 320,
      (deviceType == DeviceType.mobile)
          ? 550
          : (deviceType == DeviceType.tablet)
              ? 470
              : 460
    ];

    return Container(
      child: Column(
        children: [
          MyTitle(text: "SPARTA", logo: "?"),
          SizedBox(height: objectSpacing),
          Container(
            width: (deviceType == DeviceType.mobile)
                ? 278
                : (deviceType == DeviceType.tablet)
                    ? 498
                    : 698,
            height: heights[_pageNum],
            child: PageView.builder(
              onPageChanged: (id) {
                setState(() {
                  second = id == 1;
                  _pageNum = id;
                });
              },
              controller: controller,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: cards[index],
                );
              },
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: (deviceType == DeviceType.mobile)
                    ? 130
                    : (deviceType == DeviceType.tablet)
                        ? 240
                        : 340,
                child: Divider(
                  thickness: 5,
                  color: !second ? Colors.black : null,
                ),
              ),
              Container(
                width: (deviceType == DeviceType.mobile)
                    ? 130
                    : (deviceType == DeviceType.tablet)
                        ? 240
                        : 340,
                child: Divider(
                  thickness: 5,
                  color: second ? Colors.black : null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
