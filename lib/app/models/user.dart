import 'dart:convert';

class User {
  String? id;
  String username;
  String password;
  String? role;
  User({
    this.id,
    required this.username,
    required this.password,
    this.role,
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

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);
}
