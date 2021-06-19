class Assignment {
  final String id;
  final String name;
  final String spek;
  final DateTime deadline;
  final List<String> arrayofUsers;

  const Assignment({this.id, this.name, this.spek, this.deadline, this.arrayofUsers});

  factory Assignment.fromJson(dynamic json) {
    return Assignment(
      id: json['_id'] as String,
      name: json['name'] as String,
      spek: json['spek'] as String,
      deadline: DateTime.parse(json['deadline']),
      arrayofUsers: (json['arrayofUsers'] != null) ? List<String>.from(json['arrayofUsers']) : []
    );
  }
}