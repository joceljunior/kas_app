import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Crew {
  final String? id;
  final String name;
  final String key;
  final String? teacherId; // ID da professora responsável pela turma
  final String? teacherName; // Nome da professora (para exibição)
  final bool? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Crew({
    this.id,
    required this.name,
    required this.key,
    this.teacherId,
    this.teacherName,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'key': key});
    if (teacherId != null) {
      result.addAll({'teacherId': teacherId});
    }
    if (teacherName != null) {
      result.addAll({'teacherName': teacherName});
    }
    if (active != null) {
      result.addAll({'active': active});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt!.toIso8601String()});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.toIso8601String()});
    }

    return result;
  }

  factory Crew.fromMap(ParseObject map) {
    return Crew(
      id: map['objectId'],
      name: map['Name'] ?? map['name'] ?? '',
      key: map['Key'] ?? map['key'] ?? '',
      teacherId: map['teacherId'],
      teacherName: map['teacherName'],
      active: map['active'] ?? true,
      createdAt: map.createdAt,
      updatedAt: map.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory Crew.fromJson(ParseObject source) => Crew.fromMap(source);

  // Método para verificar se a turma tem uma professora
  bool get hasTeacher => teacherId != null && teacherId!.isNotEmpty;
}
