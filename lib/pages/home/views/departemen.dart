import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sparta/utils/ui_utils.dart';

import 'package:sparta/pages/home/views/divisi.dart';

import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_heading_text.dart';


class Departemen extends StatelessWidget {
 const Departemen ({
    this.namaDepartemen,
    this.namaKetua,
    this.foto,
    this.divisi,
  });

  final String namaDepartemen;
  final String namaKetua;
  final List<Divisi> divisi;
  final Image foto;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: [
            MyHeadingText(content: namaDepartemen),
            SizedBox(height: 20),
            MyCard(
              content: namaKetua,
              image: foto,
              title: "Kepala Dept.",
              ),
            
            for (Divisi i in divisi) Column(
                children: [
                  SizedBox(height: 20),
                  i,
                ],
              ),
          ],
        ),
    );
  }
}