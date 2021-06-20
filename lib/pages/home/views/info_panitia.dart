import 'package:flutter/material.dart';
import 'package:sparta/pages/home/views/departemen.dart';
import 'package:sparta/utils/ui_utils.dart';

import 'package:sparta/pages/home/views/divisi.dart';

import 'package:sparta/widgets/my_card.dart';
import 'package:sparta/widgets/my_text_list.dart';
import 'package:sparta/widgets/my_title.dart';
import 'package:sparta/widgets/my_heading_text.dart';

class InfoPanitia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = UIUtils.getDeviceType(context);
    double photoSize =
      (deviceType == DeviceType.mobile)
      ? 90
      : (deviceType == DeviceType.tablet)
        ? 120
        : 170;
    double objectSpacing = 40;

    return Container(
      child: Column(
        children: [
          MyTitle(text: '''INFO PANITIA''', logo: '''!'''),
          SizedBox(height: objectSpacing),
          MyHeadingText(content: '''BPH'''),
          SizedBox(height: objectSpacing),
          MyCard(
            content: '''Ghifari Farras Akbar''',
            image: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            title: '''Ketua SPARTA''',
            type: CardType.Bottom,
          ),
          SizedBox(height: objectSpacing),
          MyCard(
            content: '''Yahya Aqrom
(18219076)''',
            image: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            title: '''Sekjen''',
            type: CardType.Bottom,
          ),
          SizedBox(height: objectSpacing),
          MyCard(
            content: '''Rhea Elka Pandumpi
(13519047)''',
            image: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            title: '''Sekretaris 1''',
            type: CardType.Bottom,
          ),
          SizedBox(height: objectSpacing),
          MyCard(
            content: '''Shaffira Alya Mevia
(13519083)''',
            image: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            title: '''Sekretaris 2''',
            type: CardType.Bottom,
          ),
          SizedBox(height: objectSpacing),
          MyCard(
            content: '''Nabila Farah Debi
(18219093)''',
            image: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            title: '''Bendahara''',
            type: CardType.Bottom,
          ),
          SizedBox(height: objectSpacing),
          Divisi(
            namaDivisi: '''MSDM Panitia''',
            namaKetua: '''Arjuna Marcelino
(13519021)''',
            jabatan: '''Kepala Divisi''',
            foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            anggota: [
              '''Rexy G. R. \n
(13519010)''',
              '''Sharon B. M.
(13519092)''',
              '''Irvin A. P.
(13519162)''',
              '''Giant A. T.
(13519127)''',
              '''Nurul I. A.
(18219011)''',
              '''Kevin K. D. S.
(13519216)''',
              '''Isabella H. S.
(13519081)''',
              '''Rahmat F. A.
(18219055)'''
            ],
          ),
          SizedBox(height: objectSpacing),
          Divisi(
            namaDivisi: '''Dana Usaha''',
            namaKetua: '''Muhammad Naufal Izza F.
(13519088)''',
            jabatan: '''Kepala Divisi''',
            foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            anggota: [
              '''M. Yahya I.
(13519091)''',
              '''M. Abdi H. H.
(13519156)''',
              '''Raihan F. A.
(18219111)''',
              '''M. Iqbal A. F.
(18219116)'''
            ],
          ),
          SizedBox(height: objectSpacing),
          MyHeadingText(content: '''MSDM Kader'''),
          SizedBox(height: objectSpacing),
          MyCard(
            title: '''Kepala Divisi''',
            content: '''Zachrandika Alif Syahreza
(18219036)''',
            image: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            type: CardType.Bottom,
          ),
          SizedBox(height: objectSpacing),
          MyTextList(title: '''MSDM Kader''', list: [
            '''Nabilah E.
  (13519181)''',
            '''Ryo R.
(13519193)''',
            '''M. Hiro A. M.
(13519070)''',
            '''Shelly V.
(18219016)''',
            '''Patricia A. T. T.
(18219056)''',
            '''Gisela I. M.
(18219073)''',
            '''Edwin S. P.
(18219079)''',
            '''Anindha C. A.
(18219084)''',
            '''Imam N. H.
(13519150)''',
            '''Akifa N. U.
(13519179)''',
          ]),
          SizedBox(height: objectSpacing),
          Departemen(
            // DEPARTEMEN OPERASIONAL
            namaDepartemen: '''OPERASIONAL''',
            namaKetua: '''Faris Aziz
(13519065)''',
            foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            divisi: [
              Divisi(
                namaDivisi: '''Inovasi Teknologi''',
                namaKetua: '''Renaldi Arlin
(13519114)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
                anggota: [
                  '''Christopher C.
(13519074)''',
                  '''Kadek Surya M.
(13519165)''',
                  '''Daniel Mario R.
(13519031)''',
                  '''Jonathan C. J.
(13519144)''',
                  '''Billy Julius
(13519094)''',
                ],
              ),
              Divisi(
                namaDivisi: '''Logistik''',
                namaKetua: '''Galuh Dipa Bharata
(18219100)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
                anggota: [
                  '''Andrianata P. T.
(13519147)''',
                  '''Afifah F. Q.
(13519183)''',
                  '''Azmi M. S.
(13519151)''',
                  '''Ruhiyah F. W.
(13519034)''',
                  '''Vania A. Q.
(18219090)''',
                  '''Made K. J.
(13519176)''',
                ],
              ),
            ],
          ),
          SizedBox(height: objectSpacing),
          Departemen(
            // DEPARTEMEN PERANCANGAN DAN PENGEMBANGAN
            namaDepartemen: '''PERANCANGAN DAN PENGEMBANGAN''',
            namaKetua: '''Allief Nuriman
(13519221)''',
            foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            divisi: [
              Divisi(
                namaDivisi: '''Kurikulum''',
                namaKetua: '''Rafi Raihansyah Munandar
(13519154)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
                anggota: [
                  '''Marcelino F.
(18219006)''',
                  '''Gde Anantha P.
(13519026)''',
                  '''Ahmad F. R.
(18219026)''',
                  '''Raihan A. F.
(13519113)''',
                  '''Aindrea R. S.
(18219034)''',
                  '''M. Rifat A.
(13519205)''',
                  '''Syarifah A. G. Y.
(13519089)''',
                  '''Daffa A. P. R.
(13519107)''',
                  '''Gayuh T. R.
(13519192)''',
                ],
              ),
              Divisi(
                namaDivisi: '''Evaluasi''',
                namaKetua: '''Harith Fakhiri Setiawan
(13519161)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg",height:  photoSize, width: photoSize),
                anggota: [
                  '''Stefanus
(13519101)''',
                  '''Alvin R. A.
(13519126)''',
                  '''M. Fadli G.
(13519130)''',
                  '''Fauzan Y. I.
(13519171)''',
                  '''M. Dwinta H. C.
(13519041)''',
                  '''lbnu H.
(13519177)''',
                  '''Andres J. S.
(13519218)''',
                ],
              ),
            ],
          ),
          SizedBox(height: objectSpacing),
          Departemen(
            // DEPARTEMEN PENSUASANAAN
            namaDepartemen: '''PENSUASANAAN''',
            namaKetua: '''Habibina Arif Muzayyan
(13519125)''',
            foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            divisi: [
              Divisi(
                namaDivisi: '''Grafis''',
                namaKetua: '''Hera Shafira
(13519131)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height: photoSize, width: photoSize),
                anggota: [
                  '''Jacelyn F.
(18219097)''',
                  '''Nabelanita U.
(13519104)''',
                  '''Jeane M. E.
(13519116)''',
                  '''Karina I.
(13519166)'''
                ],
              ),
              Divisi(
                namaDivisi: '''Dokumentasi''',
                namaKetua: '''Muhammad Fahrel N. A.
(18219067)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height: photoSize, width: photoSize),
                anggota: [
                  '''Fathan A.
(18219008)''',
                  '''Almeiza A. M.
(13519066)''',
                  '''Delisha A. N.
(13519133)''',
                  '''Benidictus G. M. P.
(13519159)''',
                  '''Nabila H.
(13519097)'''
                ],
              ),
            ],
          ),
          SizedBox(height: objectSpacing),
          Departemen(
            // DEPARTEMEN IMPLEMENTASI
            namaDepartemen: '''IMPLEMENTASI''',
            namaKetua: '''M. Rafli Zamzami
(13519067)''',
            foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
            divisi: [
              Divisi(
                namaDivisi: '''Acara''',
                namaKetua: '''Albertus Agung Sinurat
(18219066)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
                anggota: [
                  '''Fabian S. D. P.
(13519140)''',
                  '''Fadel A. D.
(13519146)''',
                  '''Cindy A. N.
(18219110)''',
                  '''Dwianditya H. R.
(13519046)''',
                  '''Fakhri N. W.
(13519035)''',
                  '''Naufal A. N.
(18219068)''',
                  '''Zarfa N. P.
(18219014)''',
                  '''M. Tito. P.
(13519007)''',
                ],
              ),
              Divisi(
                namaDivisi: '''Mentor''',
                namaKetua: '''Awwala Nisa Kamila
(18219067)''',
                jabatan: '''Kepala Divisi''',
                foto: Image.asset("assets/images/blank_profile.jpg", height:  photoSize, width: photoSize),
                anggota: [
                  '''Farhan N. H. D.
(13519071)''',
                  '''Dimas F. A.
(18219001)''',
                  '''Azka A. R.
(18219101)''',
                  '''Gilbert C. S.
(18219005)''',
                  '''M. Hanif A. N.
(18219077)''',
                  '''Ridho D.
(13519038)''',
                  '''Widya A. P.
(13519105)''',
                  '''Justin D. I.
(18219095)''',
                  '''M. Husnul D.
(18219010)''',
                  '''Nicholas D.
(18219028)''',
                  '''Cahaya N. S.
(18219059)''',
                  '''Nabil N.
(13519168)''',
                  '''Natasya J. A.
(18219065)''',
                  '''M. Kautsar F.
(18219039)''',
                  '''Tarbiyatun N.
(18219023)''',
                  '''Daru B. D.
(13519080)''',
                  '''Rafidika S.
(13519207)''',
                  '''Hafid A. D.
(13519028)''',
                  '''Handy Z.
(18219060)''',
                  '''Girvin J.
(13519096)''',
                  '''M. Fathurrahman A.
(18219054)''',
                  '''M. Dehan A. K.
(13519200)''',
                  '''Shafira N. A.
(13519040)''',
                  '''Leony A.
(18219032)''',
                  '''Christopher D. L.
(18219037)''',
                  '''Bonaventura B. S.
(18219017)''',
                  '''Rahmat W.
(18219040)''',
                  '''M. Faiq D. U. H.
(18219013)''',
                  '''Wildan D. H.
(18219115)''',
                  '''Ida B. R. A. M.
(18219117)''',
                  '''Indira D.
(18219051)''',
                  '''Shifa S.
(13519106)''',
                  '''Regina D. A. H.
(18219030)''',
                  '''M. Azhar F.
(13519020)''',
                  '''M. Akram A. B.
(13519142)''',
                  '''Richard R.
(13519185)''',
                  '''Arsa D. G.
(13519037)''',
                  '''Syamil C. A.
(13519052)''',
                  '''M. Rabbani B.
(18219118)''',
                  '''Nadilla P. P.
(18219108)''',
                  '''Fauzan R. W.
(18219104)''',
                  '''M. Rifandy Z.
(18219021)''',
                  '''M. Atthaumar R.
(13519148)''',
                  '''Nizamixavier R. L.
(13519085)''',
                  '''Rahmah K. N.
(13519013)''',
                  '''M. Raflie Dwi P.
(18219035)''',
                ],
              ),
            ],
          ),
          SizedBox(height: objectSpacing),
        ],
      ),
    );
  }
}
