import 'package:flutter/material.dart';

class Kepala {
  Kepala({
    this.nama,
    this.nim,
    this.jabatan,
    this.bidang,
    this.foto,
    this.anggota,
  });

  final nama;
  final nim;
  final jabatan;
  final bidang;
  final foto;
  List<Anggota> anggota;
}

class Anggota {
  Anggota({this.nama, this.nim});

  String nama;
  String nim;
}

final ketua = Kepala(
  nama: 'Ghifari Farras Azhar',
  nim: '(18219105)',
  jabatan: 'KETUA',
  foto: 'assets/images/panitia/Ketua.png',
  anggota: null,
);

final kesekjenan = [
  Kepala(
    nama: 'Yahya Aqrom',
    nim: '(18219076)',
    jabatan: 'SEKJEN',
    foto: 'assets/images/blank_profile.jpg',
    anggota: null,
  ),
  Kepala(
    nama: 'Nabila Farah Debi',
    nim: '(18219093)',
    jabatan: 'BENDAHARA',
    foto: 'assets/images/panitia/Bendahara.png',
    anggota: null,
  ),
  Kepala(
    nama: 'Rhea Elka Pandumpi',
    nim: '(13519047)',
    jabatan: 'SEKRETARIS 1',
    foto: 'assets/images/panitia/Sekretaris_1.png',
    anggota: null,
  ),
  Kepala(
    nama: 'Shaffira Alya Mevia',
    nim: '(13519083)',
    jabatan: 'SEKRETARIS 2',
    foto: 'assets/images/panitia/Sekretaris_2.png',
    anggota: null,
  ),
];

final msdmPanitia = Kepala(
  nama: 'Arjuna Marcelino',
  nim: '(13519021)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/MSDM_Panit.png',
  anggota: [
    Anggota(
      nama: 'Rexy G. R.',
      nim: '(13519010)',
    ),
    Anggota(
      nama: 'Sharon B. M.',
      nim: '(13519092)',
    ),
    Anggota(
      nama: 'Irvin A. P.',
      nim: '(13519162)',
    ),
    Anggota(
      nama: 'Giant A. T.',
      nim: '(13519127)',
    ),
    Anggota(
      nama: 'Nurul I. A.',
      nim: '(18219011)',
    ),
    Anggota(
      nama: 'Kevin K. D. S.',
      nim: '(13519216)',
    ),
    Anggota(
      nama: 'Isabella H. S.',
      nim: '(13519081)',
    ),
    Anggota(
      nama: 'Rahmat F. A.',
      nim: '(18219055)',
    ),
  ],
);

final danaUsaha = Kepala(
  nama: 'Muhammad Naufal Izza F.',
  nim: '(13519088)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Danus.png',
  anggota: [
    Anggota(
      nama: 'M. Yahya I.',
      nim: '(13519091)',
    ),
    Anggota(
      nama: 'M. Abdi H. H.',
      nim: '(13519156)',
    ),
    Anggota(
      nama: 'Raihan F. A.',
      nim: '(18219111)',
    ),
    Anggota(
      nama: 'M. Iqbal A. F.',
      nim: '(18219116)',
    ),
  ],
);

final msdmKader = Kepala(
  nama: 'Zachrandika Alif Syahreza',
  nim: '(18219036)',
  jabatan: 'KEPALA DEPT.',
  foto: 'assets/images/panitia/MSDM_Kader.png',
  anggota: [
    Anggota(
      nama: 'Nabilah E.',
      nim: '(13519181)',
    ),
    Anggota(
      nama: 'Ryo R.',
      nim: '(13519193)',
    ),
    Anggota(
      nama: 'M. Hiro A. M.',
      nim: '(13519070)',
    ),
    Anggota(
      nama: 'Shelly V.',
      nim: '(18219016)',
    ),
    Anggota(
      nama: 'Patricia A. T. T.',
      nim: '(18219056)',
    ),
    Anggota(
      nama: 'Gisela I. M.',
      nim: '(18219073)',
    ),
    Anggota(
      nama: 'Edwin S. P.',
      nim: '(18219079)',
    ),
    Anggota(
      nama: 'Anindha C. A.',
      nim: '(18219084)',
    ),
    Anggota(
      nama: 'Imam N. H.',
      nim: '(13519150)',
    ),
    Anggota(
      nama: 'Akifa N. U.',
      nim: '(13519179)',
    ),
  ],
);

final operasional = Kepala(
  nama: 'Faris Aziz',
  nim: '(13519065)',
  jabatan: 'KEPALA DEPT.',
  foto: 'assets/images/panitia/Operasional.png',
);

final it = Kepala(
  nama: 'Renaldi Arlin',
  nim: '(13519114)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/IT.png',
  anggota: [
    Anggota(
      nama: 'Christopher C.',
      nim: '(13519074)',
    ),
    Anggota(
      nama: 'Kadek Surya M.',
      nim: '(13519165)',
    ),
    Anggota(
      nama: 'Daniel Mario R.',
      nim: '(13519031)',
    ),
    Anggota(
      nama: 'Jonathan C. J.',
      nim: '(13519144)',
    ),
    Anggota(
      nama: 'Billy Julius',
      nim: '(13519094)',
    ),
  ],
);

final logistik = Kepala(
  nama: 'Galuh Dipa Bharata',
  nim: '(18219100)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Logistik.png',
  anggota: [
    Anggota(
      nama: 'Andrianata P. T.',
      nim: '(13519147)',
    ),
    Anggota(
      nama: 'Afifah F. Q.',
      nim: '(13519183)',
    ),
    Anggota(
      nama: 'Azmi M. S.',
      nim: '(13519151)',
    ),
    Anggota(
      nama: 'Ruhiyah F. W.',
      nim: '(13519034)',
    ),
    Anggota(
      nama: 'Vania A. Q.',
      nim: '(18219090)',
    ),
    Anggota(
      nama: 'Made K. J.',
      nim: '(13519176)',
    ),
    Anggota(
      nama: 'M. Raflie Dwi P.',
      nim: '(18219035)',
    ),
  ],
);

final pnp = Kepala(
  nama: 'Allief Nuriman',
  nim: '(13519221)',
  jabatan: 'KEPALA DEPT.',
  foto: 'assets/images/panitia/PP.png',
);

final kurikulum = Kepala(
    nama: 'Rafi Raihansyah Munandar',
    nim: '(13519154)',
    jabatan: 'KEPALA DIVISI',
    foto: 'assets/images/panitia/Kurikulum.png',
    anggota: [
      Anggota(
        nama: 'Marcelino F.',
        nim: '(18219006)',
      ),
      Anggota(
        nama: 'Gde Anantha P.',
        nim: '(13519026)',
      ),
      Anggota(
        nama: 'Ahmad F. R.',
        nim: '(18219026)',
      ),
      Anggota(
        nama: 'Raihan A. F.',
        nim: '(13519113)',
      ),
      Anggota(
        nama: 'Aindrea R. S.',
        nim: '(18219034)',
      ),
      Anggota(
        nama: 'M. Rifat A.',
        nim: '(13519205)',
      ),
      Anggota(
        nama: 'Syarifah A. G. Y.',
        nim: '(13519089)',
      ),
      Anggota(
        nama: 'Daffa A. P. R.',
        nim: '(13519107)',
      ),
      Anggota(
        nama: 'Gayuh T. R.',
        nim: '(13519192)',
      ),
    ]);

final evaluasi = Kepala(
  nama: 'Harith Fakhiri Setiawan',
  nim: '(13519161)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Evaluasi.png',
  anggota: [
    Anggota(
      nama: 'Stefanus',
      nim: '(13519101)',
    ),
    Anggota(
      nama: 'Alvin R. A.',
      nim: '(13519126)',
    ),
    Anggota(
      nama: 'M. Fadli G.',
      nim: '(13519130)',
    ),
    Anggota(
      nama: 'Fauzan Y. I.',
      nim: '(13519171)',
    ),
    Anggota(
      nama: 'M. Dwinta H. C.',
      nim: '(13519041)',
    ),
    Anggota(
      nama: 'lbnu H.',
      nim: '(13519177)',
    ),
    Anggota(
      nama: 'Andres J. S.',
      nim: '(13519218)',
    ),
  ],
);

final pensus = Kepala(
  nama: 'Habibina Arif Muzayyan',
  nim: '(13519125)',
  jabatan: 'KEPALA DEPT.',
  foto: 'assets/images/panitia/Pensus.png',
);

final grafis = Kepala(
  nama: 'Hera Shafira',
  nim: '(13519131)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Grafis.png',
  anggota: [
    Anggota(
      nama: 'Jacelyn F.',
      nim: '(18219097)',
    ),
    Anggota(
      nama: 'Nabelanita U.',
      nim: '(13519104)',
    ),
    Anggota(
      nama: 'Jeane M. E.',
      nim: '(13519116)',
    ),
    Anggota(
      nama: 'Karina I.',
      nim: '(13519166)',
    ),
  ],
);

final dokmen = Kepala(
  nama: 'Muhammad Fahrel N. A.',
  nim: '(18219067)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Dokum.png',
  anggota: [
    Anggota(
      nama: 'Fathan A.',
      nim: '(18219008)',
    ),
    Anggota(
      nama: 'Almeiza A. M.',
      nim: '(13519066)',
    ),
    Anggota(
      nama: 'Delisha A. N..',
      nim: '(13519133)',
    ),
    Anggota(
      nama: 'Benidictus G. M. P.',
      nim: '(13519159)',
    ),
    Anggota(
      nama: 'Nabila H.',
      nim: '(13519097)',
    ),
  ],
);

final implementasi = Kepala(
  nama: 'M. Rafli Zamzami',
  nim: '(13519067)',
  jabatan: 'KEPALA DEPT.',
  foto: 'assets/images/panitia/Implementasi.png',
);

final acara = Kepala(
  nama: 'Albertus Agung Sinurat',
  nim: '(18219066)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Acara.png',
  anggota: [
    Anggota(
      nama: 'Fabian S. D. P.',
      nim: '(13519140)',
    ),
    Anggota(
      nama: 'Fadel A. D.',
      nim: '(13519146)',
    ),
    Anggota(
      nama: 'Cindy A. N.',
      nim: '(18219110)',
    ),
    Anggota(
      nama: 'Dwianditya H. R.',
      nim: '(13519046)',
    ),
    Anggota(
      nama: 'Fakhri N. W.',
      nim: '(13519035)',
    ),
    Anggota(
      nama: 'Naufal A. N.',
      nim: '(18219068)',
    ),
    Anggota(
      nama: 'Zarfa N. P.',
      nim: '(18219014)',
    ),
    Anggota(
      nama: 'M. Tito. P.',
      nim: '(13519007)',
    ),
  ],
);

final mentor = Kepala(
  nama: 'Awwala Nisa Kamila',
  nim: '(18219067)',
  jabatan: 'KEPALA DIVISI',
  foto: 'assets/images/panitia/Mentor.png',
  anggota: [
    Anggota(
      nama: 'Farhan N. H. D.',
      nim: '(13519071)',
    ),
    Anggota(
      nama: 'Dimas F. A.',
      nim: '(18219001)',
    ),
    Anggota(
      nama: 'Azka A. R.',
      nim: '(18219101)',
    ),
    Anggota(
      nama: 'Gilbert C. S.',
      nim: '(18219005)',
    ),
    Anggota(
      nama: 'M. Hanif A. N.',
      nim: '(18219077)',
    ),
    Anggota(
      nama: 'Ridho D.',
      nim: '(13519038)',
    ),
    Anggota(
      nama: 'Widya A. P.',
      nim: '(13519105)',
    ),
    Anggota(
      nama: 'Justin D. I.',
      nim: '(18219095)',
    ),
    Anggota(
      nama: 'M. Husnul D.',
      nim: '(18219010)',
    ),
    Anggota(
      nama: 'Nicholas D.',
      nim: '(18219028)',
    ),
    Anggota(
      nama: 'Cahaya N. S.',
      nim: '(18219059)',
    ),
    Anggota(
      nama: 'Nabil N.',
      nim: '(13519168)',
    ),
    Anggota(
      nama: 'Natasya J. A.',
      nim: '(18219065)',
    ),
    Anggota(
      nama: 'M. Kautsar F.',
      nim: '(18219039)',
    ),
    Anggota(
      nama: 'Tarbiyatun N.',
      nim: '(18219023)',
    ),
    Anggota(
      nama: 'Daru B. D.',
      nim: '(13519080)',
    ),
    Anggota(
      nama: 'Rafidika S.',
      nim: '(13519207)',
    ),
    Anggota(
      nama: 'Hafid A. D.',
      nim: '(13519028)',
    ),
    Anggota(
      nama: 'Handy Z.',
      nim: '(18219060)',
    ),
    Anggota(
      nama: 'Girvin J.',
      nim: '(13519096)',
    ),
    Anggota(
      nama: 'M. Fathurrahman A.',
      nim: '(18219054)',
    ),
    Anggota(
      nama: 'M. Dehan A. K.',
      nim: '(13519200)',
    ),
    Anggota(
      nama: 'Shafira N. A.',
      nim: '(13519040)',
    ),
    Anggota(
      nama: 'Leony A.',
      nim: '(18219032)',
    ),
    Anggota(
      nama: 'Christopher D. L.',
      nim: '(18219037)',
    ),
    Anggota(
      nama: 'Bonaventura B. S.',
      nim: '(18219017)',
    ),
    Anggota(
      nama: 'Rahmat W.',
      nim: '(18219040)',
    ),
    Anggota(
      nama: 'M. Faiq D. U. H.',
      nim: '(18219013)',
    ),
    Anggota(
      nama: 'Wildan D. H.',
      nim: '(18219115)',
    ),
    Anggota(
      nama: 'Ida B. R. A. M.',
      nim: '(18219117)',
    ),
    Anggota(
      nama: 'Indira D.',
      nim: '(18219051)',
    ),
    Anggota(
      nama: 'Shifa S.',
      nim: '(13519106)',
    ),
    Anggota(
      nama: 'Regina D. A. H.',
      nim: '(18219030)',
    ),
    Anggota(
      nama: 'M. Azhar F.',
      nim: '(13519020)',
    ),
    Anggota(
      nama: 'M. Akram A. B.',
      nim: '(13519142)',
    ),
    Anggota(
      nama: 'Richard R.',
      nim: '(13519185)',
    ),
    Anggota(
      nama: 'Arsa D. G.',
      nim: '(13519037)',
    ),
    Anggota(
      nama: 'Syamil C. A.',
      nim: '(13519052)',
    ),
    Anggota(
      nama: 'M. Rabbani B.',
      nim: '(18219118)',
    ),
    Anggota(
      nama: 'Nadilla P. P.',
      nim: '(18219108)',
    ),
    Anggota(
      nama: 'Fauzan R. W.',
      nim: '(18219104)',
    ),
    Anggota(
      nama: 'M. Rifandy Z.',
      nim: '(18219021)',
    ),
    Anggota(
      nama: 'M. Atthaumar R.',
      nim: '(13519148)',
    ),
    Anggota(
      nama: 'Nizamixavier R. L.',
      nim: '(13519085)',
    ),
    Anggota(
      nama: 'Rahmah K. N.',
      nim: '(13519013)',
    ),
  ],
);

final kepanitiaan = [
  {'ketua': ketua, 'kesekjenan': kesekjenan},
  {'msdmPanitia': msdmPanitia, 'danus': danaUsaha},
  {'msdmKader': msdmKader},
  {
    'namaBidang': "OPERASIONAL",
    'kabid': operasional,
    'divisi1': "INOVASI TEKNOLOGI",
    'kadiv1': it,
    'divisi2': "LOGISTIK",
    'kadiv2': logistik,
  },
  {
    'namaBidang': "PERANCANGAN DAN PENGEMBANGAN",
    'kabid': pnp,
    'divisi1': "KURIKULUM",
    'kadiv1': kurikulum,
    'divisi2': "EVALUASI",
    'kadiv2': evaluasi,
  },
  {
    'namaBidang': "PENSUASANAAN",
    'kabid': pensus,
    'divisi1': "GRAFIS",
    'kadiv1': grafis,
    'divisi2': "DOKUMENTASI",
    'kadiv2': dokmen,
  },
  {
    'namaBidang': "IMPLEMENTASI",
    'kabid': implementasi,
    'divisi1': "ACARA",
    'kadiv1': acara,
    'divisi2': "MENTOR",
    'kadiv2': mentor,
  },
];
