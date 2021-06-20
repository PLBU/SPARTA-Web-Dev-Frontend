class Submission{
  final String id;
  String submissionLink;
  final String pengirim;
  final String assignment;

  Submission({ this.id, this.submissionLink, this.pengirim, this.assignment });

  factory Submission.fromJson(dynamic json) {
    return Submission(
      id: json['_id'] as String,
      submissionLink: json['submissionLink'] as String,
      pengirim: json['pengirim'] as String,
      assignment: json['assignment'] as String,
    );
  }
} 