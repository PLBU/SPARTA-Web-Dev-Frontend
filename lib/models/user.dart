import 'dart:typed_data';

class User {
  String id;
  String instagram;
  String namaLengkap;
  String namaPanggilan;
  String email;
  String password;
  String nim;
  String jurusan;
  Uint8List foto;
  int skor;
  int kelompok;
  String status;
  DateTime tanggalLahir;

  User({
    this.id,
    this.instagram,
    this.namaLengkap,
    this.namaPanggilan,
    this.email,
    this.password,
    this.nim,
    this.jurusan,
    this.foto,
    this.skor,
    this.kelompok,
    this.status,
    this.tanggalLahir,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['_id'] as String,
      instagram: (json['instagram'] == null) ? "" : json['instagram'] as String,
      namaLengkap: json['namaLengkap'] as String,
      namaPanggilan: json['namaPanggilan'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      nim: json['nim'] as String,
      jurusan: json['jurusan'] as String,
      foto: (json['foto'] == null)
          ? null
          : Uint8List.fromList(
              new List<int>.from(json['foto']['data']['data'])),
      // To use foto as Image, use Image.memory(User.foto) or MemoryImage(User.foto)
      skor: json['skor'] as int,
      kelompok: json['kelompok'] as int,
      status: json['status'] == null ? "" : json['status'] as String,
      tanggalLahir: DateTime.parse(json['tanggalLahir']),
    );
  }
}
