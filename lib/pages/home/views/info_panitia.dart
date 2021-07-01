import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sparta/pages/home/views/departemen.dart';
import 'package:sparta/utils/ui_utils.dart';

import 'package:sparta/pages/home/views/divisi.dart';
import 'package:sparta/pages/home/data/panitia.dart';
import 'package:sparta/widgets/my_button.dart';

import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_text_list.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_heading_text.dart';

class InfoPanitia extends StatefulWidget {
  InfoPanitia();

  @override
  _InfoPanitiaState createState() => _InfoPanitiaState();
}

class _InfoPanitiaState extends State<InfoPanitia> {
  List<String> pageName = [
    "Ketua & Kesekjenan",
    "Kesekjenan",
    "MSDM Kader",
    "Operasional",
    "Perancangan & Pengembangan",
    "Pensuasanaan",
    "Implementasi",
  ];

  List<double> heightMobile = [1300, 1000, 500, 1350, 1400, 1350, 1350];
  List<double> heightTablet = [1650, 1350, 650, 1750, 1800, 1750, 1750];
  List<double> heightDesktop = [1250, 900, 500, 1400, 1400, 1400, 1400];

  int _pageNum = 0;
  bool _next, _prev;

  dynamic getPanitiaCard(idx) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double spaceHeight = 40;
    double spaceWidth = (deviceType == DeviceType.mobile)
        ? 125
        : (deviceType == DeviceType.tablet)
            ? 150
            : 160;
    double photoSize = (deviceType == DeviceType.mobile)
        ? 90
        : (deviceType == DeviceType.tablet)
            ? 120
            : 170;

    dynamic panitia = kepanitiaan[idx];
    if (idx == 0) {
      Kepala ketua = panitia['ketua'];
      List<Kepala> sekjen = panitia['kesekjenan'];
      return Column(
        children: [
          MyCard(
            content: '${ketua.nama}\n${ketua.nim}',
            title: 'KETUA',
            image: Image.asset(
              ketua.foto,
              height: photoSize,
              width: photoSize,
            ),
            type: CardType.Bottom,
          ),
          SizedBox(height: spaceHeight),
          (deviceType != DeviceType.mobile && deviceType != DeviceType.tablet)
              ? Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyCard(
                          content: '${sekjen[0].nama}\n${sekjen[0].nim}',
                          title: 'SEKJEN',
                          image: Image.asset(
                            sekjen[0].foto,
                            height: photoSize,
                            width: photoSize,
                          ),
                          type: CardType.Bottom,
                        ),
                        SizedBox(width: spaceWidth),
                        MyCard(
                          content: '${sekjen[1].nama}\n${sekjen[1].nim}',
                          title: 'BENDAHARA',
                          image: Image.asset(
                            sekjen[1].foto,
                            height: photoSize,
                            width: photoSize,
                          ),
                          type: CardType.Bottom,
                        ),
                      ],
                    ),
                    SizedBox(height: spaceHeight),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyCard(
                          content: '${sekjen[2].nama}\n${sekjen[2].nim}',
                          title: 'SEKRETARIS 1',
                          image: Image.asset(
                            sekjen[2].foto,
                            height: photoSize,
                            width: photoSize,
                          ),
                          type: CardType.Bottom,
                        ),
                        SizedBox(width: spaceWidth),
                        MyCard(
                          content: '${sekjen[3].nama}\n${sekjen[3].nim}',
                          title: 'SEKRETARIS 2',
                          image: Image.asset(
                            sekjen[3].foto,
                            height: photoSize,
                            width: photoSize,
                          ),
                          type: CardType.Bottom,
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    MyCard(
                      content: '${sekjen[0].nama}\n${sekjen[0].nim}',
                      title: 'SEKJEN',
                      image: Image.asset(
                        sekjen[0].foto,
                        height: photoSize,
                        width: photoSize,
                      ),
                      type: CardType.Bottom,
                    ),
                    SizedBox(height: spaceHeight),
                    MyCard(
                      content: '${sekjen[1].nama}\n${sekjen[1].nim}',
                      title: 'BENDAHARA',
                      image: Image.asset(
                        sekjen[1].foto,
                        height: photoSize,
                        width: photoSize,
                      ),
                      type: CardType.Bottom,
                    ),
                    SizedBox(height: spaceHeight),
                    MyCard(
                      content: '${sekjen[2].nama}\n${sekjen[2].nim}',
                      title: 'SEKRETARIS 1',
                      image: Image.asset(
                        sekjen[2].foto,
                        height: photoSize,
                        width: photoSize,
                      ),
                      type: CardType.Bottom,
                    ),
                    SizedBox(height: spaceHeight),
                    MyCard(
                      content: '${sekjen[3].nama}\n${sekjen[3].nim}',
                      title: 'SEKRETARIS 2',
                      image: Image.asset(
                        sekjen[3].foto,
                        height: photoSize,
                        width: photoSize,
                      ),
                      type: CardType.Bottom,
                    ),
                  ],
                ),
        ],
      );
    } else if (idx == 1) {
      Kepala msdmPanit = panitia['msdmPanitia'];
      Kepala danus = panitia['danus'];
      Kepala msdmKader = panitia['msdmKader'];

      return Column(
        children: [
          Divisi(
            namaDivisi: "MSDM PANITIA",
            namaKetua: '${msdmPanit.nama}\n${msdmPanit.nim}',
            jabatan: msdmPanit.jabatan,
            foto: Image.asset(
              msdmPanit.foto,
              height: photoSize,
              width: photoSize,
            ),
            anggota: msdmPanit.anggota
                .map((val) => '${val.nama}\n${val.nim}')
                .toList(),
          ),
          SizedBox(height: spaceHeight),
          Divisi(
            namaDivisi: "DANA USAHA",
            namaKetua: '${danus.nama}\n${danus.nim}',
            jabatan: danus.jabatan,
            foto: Image.asset(
              danus.foto,
              height: photoSize,
              width: photoSize,
            ),
            anggota:
                danus.anggota.map((val) => '${val.nama}\n${val.nim}').toList(),
          ),
        ],
      );
    } else if (idx == 2) {
      Kepala msdmKader = panitia['msdmKader'];

      return Column(children: [
        Divisi(
          namaDivisi: "MSDM KADER",
          namaKetua: '${msdmKader.nama}\n${msdmKader.nim}',
          foto: Image.asset(
            msdmKader.foto,
            height: photoSize,
            width: photoSize,
          ),
          jabatan: "KEPALA DEPT.",
          anggota: msdmKader.anggota
              .map((val) => '${val.nama}\n${val.nim}')
              .toList(),
        ),
      ]);
    } else {
      Kepala kabid = panitia['kabid'];
      Kepala kadiv1 = panitia['kadiv1'];
      Kepala kadiv2 = panitia['kadiv2'];

      return Column(
        children: [
          Departemen(
            namaDepartemen: panitia['namaBidang'],
            namaKetua: '${kabid.nama}\n${kabid.nim}',
            foto: Image.asset(
              kabid.foto,
              height: photoSize,
              width: photoSize,
            ),
            divisi: [
              Divisi(
                namaDivisi: panitia['divisi1'],
                namaKetua: '${kadiv1.nama}\n${kadiv1.nim}',
                jabatan: kadiv1.jabatan,
                foto: Image.asset(
                  kadiv1.foto,
                  height: photoSize,
                  width: photoSize,
                ),
                anggota: kadiv1.anggota
                    .map((val) => '${val.nama}\n${val.nim}')
                    .toList(),
              ),
              Divisi(
                namaDivisi: panitia['divisi2'],
                namaKetua: '${kadiv2.nama}\n${kadiv2.nim}',
                jabatan: kadiv2.jabatan,
                foto: Image.asset(
                  kadiv2.foto,
                  height: photoSize,
                  width: photoSize,
                ),
                anggota: kadiv2.anggota
                    .map((val) => '${val.nama}\n${val.nim}')
                    .toList(),
              ),
            ],
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double objectSpacing = 40;
    double respHeight = (deviceType == DeviceType.mobile)
        ? heightMobile[_pageNum]
        : (deviceType == DeviceType.tablet)
            ? heightTablet[_pageNum]
            : heightDesktop[_pageNum];
    final PageController controller = PageController(initialPage: 0);
    setState(() {
      _next = (_pageNum + 1) % kepanitiaan.length > 0;
      _prev = _pageNum % kepanitiaan.length > 0;
    });

    return Container(
      child: Column(
        children: [
          MyTitle(text: '''INFO PANITIA''', logo: '''!'''),
          SizedBox(
              height: (deviceType == DeviceType.mobile)
                  ? objectSpacing
                  : objectSpacing * 1.5),
          Container(
            width: (deviceType == DeviceType.mobile)
                ? 350
                : (deviceType == DeviceType.tablet)
                    ? 600
                    : 1000,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_prev)
                  MyButton(
                    text: pageName[(_pageNum - 1) % kepanitiaan.length],
                    buttonType: ButtonType.black,
                    handler: () {
                      controller.animateToPage(
                        controller.page.toInt() - 1,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                SizedBox(width: (deviceType == DeviceType.mobile) ? 10 : 50),
                if (_next)
                  MyButton(
                    text: pageName[(_pageNum + 1) % kepanitiaan.length],
                    buttonType: ButtonType.black,
                    handler: () {
                      controller.animateToPage(
                        controller.page.toInt() + 1,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
              ],
            ),
          ),
          SizedBox(height: (deviceType == DeviceType.mobile) ? 40 : 60),
          Container(
            height: respHeight,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (pageID) {
                setState(() {
                  _pageNum = pageID;
                });
              },
              itemCount: kepanitiaan.length,
              itemBuilder: ((context, index) {
                return getPanitiaCard(index);
              }),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
