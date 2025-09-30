import 'dart:convert';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User {
  String? id;
  String username;
  String password;
  String? role;
  String? name;
  String? email;
  String? phone;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    required this.username,
    required this.password,
    this.role,
    this.name,
    this.email,
    this.phone,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'username': username});
    result.addAll({'password': password});
    if (role != null) {
      result.addAll({'role': role});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toString(),
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      role: map['role'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      active: map['active'],
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  factory User.fromParseObject(ParseObject parseObject) {
    return User(
      id: parseObject.objectId,
      username: parseObject['username'] ?? '',
      password: '', // Não retornamos a senha por segurança
      role: parseObject['Role'] ?? parseObject['role'],
      name: parseObject['name'],
      email: parseObject['email'],
      phone: parseObject['phone'],
      active: parseObject['active'] ?? true,
      createdAt: parseObject.createdAt,
      updatedAt: parseObject.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);

  // Métodos de conveniência para roles
  bool get isMaster => role?.toLowerCase() == 'master';
  bool get isTeacher =>
      role?.toLowerCase() == 'teacher' || role?.toLowerCase() == 'professora';
  bool get isActive => active ?? true;
}
