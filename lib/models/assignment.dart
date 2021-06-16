class Assignment {
  final String id;
  final String name;
  final String spek;
  final DateTime deadline;
  final List<String> arrayOfUsers;

  const Assignment({this.id, this.name, this.spek, this.deadline, this.arrayOfUsers});

  factory Assignment.fromJson(dynamic json) {
    return Assignment(
      id: json['_id'] as String,
      name: json['name'] as String,
      spek: json['spek'] as String,
      deadline: json['deadline'] as DateTime,
      arrayOfUsers: new List<String>.from(json['arrayOfUsers'])
    );
  }
}