import 'dart:convert';

class Session {
  int? idUSer;
  String? nameUSer;
  String? roleUser;
  String? passwordUser;
  Session({
    this.idUSer,
    this.nameUSer,
    this.roleUser,
    this.passwordUser,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (idUSer != null) {
      result.addAll({'idUSer': idUSer});
    }
    if (nameUSer != null) {
      result.addAll({'nameUSer': nameUSer});
    }
    if (roleUser != null) {
      result.addAll({'roleUser': roleUser});
    }
    result.addAll({'passwordUser': passwordUser});

    return result;
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      idUSer: map['idUSer']?.toInt(),
      nameUSer: map['nameUSer'],
      roleUser: map['roleUser'],
      passwordUser: map['passwordUser'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));
}
