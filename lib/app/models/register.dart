import 'dart:convert';

class Register {
  final int? id;
  final int crewId;
  final int studentId;
  final bool participation;
  final String? justification;
  final DateTime dateCreate;
  Register({
    this.id,
    required this.crewId,
    required this.studentId,
    required this.participation,
    required this.justification,
    required this.dateCreate,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'crewId': crewId.toInt()});
    result.addAll({'studentId': studentId.toInt()});
    result.addAll({'participation': participation});
    result.addAll({'justification': justification});
    result.addAll({'dateCreate': dateCreate.toString()});

    return result;
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      id: map['id']?.toInt(),
      crewId: map['crewId']?.toInt() ?? 0,
      studentId: map['studentId']?.toInt() ?? 0,
      participation: map['participation'] ?? false,
      justification: map['justification'] ?? '',
      dateCreate: DateTime.parse(map['dateCreate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(Map<String, dynamic> source) =>
      Register.fromMap(source);
}
