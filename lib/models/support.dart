class Support {
  final String id;
  final String penerima;
  final String pengirim;
  final String namaPengirim;
  final String text;

  const Support({this.id, this.penerima, this.pengirim, this.namaPengirim, this.text});

  factory Support.fromJson(dynamic json) {
    return Support(
      id: json['_id'] as String,
      penerima: json['penerima'] as String,
      pengirim: json['pengirim'] as String,
      namaPengirim: json['namaPengirim'] as String,
      text: json['text'] as String,
    );
  }
} 