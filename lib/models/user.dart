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
  String picture;
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
    this.picture,
    this.skor,
    this.kelompok,
    this.status,
    this.tanggalLahir,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['_id'] as String,
      instagram: (json['instagram'] == null) ? "" : json['instagram'] as String,
      namaLengkap: (json['namaLengkap'] == null) ? "" : json['namaLengkap'] as String,
      namaPanggilan: (json['namaPanggilan'] == null) ? "" : json['namaPanggilan'] as String,
      email: (json['email'] == null) ? "" : json['email'] as String,
      password: json['password'] as String,
      nim: json['nim'] as String,
      jurusan: json['jurusan'] as String,
      picture: (json['picture'] == null)
          ? null
          : json['picture'] as String,
      skor: json['skor'] as int,
      kelompok: json['kelompok'] as int,
      status: json['status'] == null ? "" : json['status'] as String,
      tanggalLahir: (json['tanggalLahir'] == null) ? null : DateTime.parse(json['tanggalLahir']),
    );
  }
}
