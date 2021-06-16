class Support {
  final String id;
  final String penerima;
  final String pengirim;
  final String text;

  const Support({this.id, this.penerima, this.pengirim, this.text});

  factory Support.fromJson(dynamic json) {
    return Support(
      id: json['_id'] as String,
      penerima: json['penerima'] as String,
      pengirim: json['pengirim'] as String,
      text: json['text'] as String,
    );
  }
} 