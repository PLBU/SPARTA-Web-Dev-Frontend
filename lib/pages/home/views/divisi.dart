import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';
import 'package:sparta/widgets/my_text_list.dart';
import 'package:sparta/widgets/my_card.dart';

class Divisi extends StatelessWidget {
  const Divisi({
    this.namaDivisi,
    this.jabatan,
    this.namaKetua,
    this.anggota,
    this.foto,
  });

  final String namaDivisi;
  final String jabatan;
  final String namaKetua;
  final List<String> anggota;
  final Image foto;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);

    return Container(
        child:
            (deviceType == DeviceType.mobile || deviceType == DeviceType.tablet)
                ? Column(
                    children: [
                      MyCard(
                        content: namaKetua,
                        image: foto,
                        title: jabatan,
                        type: CardType.Bottom,
                        height: (deviceType == DeviceType.mobile) ? 190 : 250,
                      ),
                      SizedBox(height: 20),
                      MyTextList(
                        title: namaDivisi,
                        list: anggota,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyCard(
                        content: namaKetua,
                        image: foto,
                        title: jabatan,
                        type: CardType.Bottom,
                        height: (deviceType == DeviceType.tablet) ? 250 : 330,
                      ),
                      SizedBox(width: 40),
                      MyTextList(
                        title: namaDivisi,
                        list: anggota,
                      ),
                    ],
                  ));
  }
}
