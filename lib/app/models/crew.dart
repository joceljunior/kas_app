import 'dart:convert';

class Crew {
  final int? id;
  final String name;
  final String key;
  Crew({
    this.id,
    required this.name,
    required this.key,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'key': key});

    return result;
  }

  factory Crew.fromMap(Map<String, dynamic> map) {
    return Crew(
      id: map['id'],
      name: map['name'],
      key: map['key'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Crew.fromJson(Map<String, dynamic> source) => Crew.fromMap(source);
}
