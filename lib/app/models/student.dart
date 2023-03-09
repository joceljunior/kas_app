import 'dart:convert';

import 'package:kas_app/app/models/crew.dart';

class Student {
  final int? id;
  final String name;
  final Crew crew;
  final String mother;
  final String father;
  final String schoolName;
  final String? schoolGrade;
  final String telephone;
  final String address;
  final DateTime birthday;
  final String allergy;
  final bool useOfImage;
  final bool active;
  final DateTime dateCreate;
  Student({
    this.id,
    required this.name,
    required this.crew,
    required this.mother,
    required this.father,
    required this.schoolName,
    this.schoolGrade,
    required this.telephone,
    required this.address,
    required this.birthday,
    required this.allergy,
    required this.useOfImage,
    required this.active,
    required this.dateCreate,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'crew': crew.toMap()});
    result.addAll({'mother': mother});
    result.addAll({'father': father});
    result.addAll({'schoolName': schoolName});
    if (schoolGrade != null) {
      result.addAll({'schoolGrade': schoolGrade});
    }
    result.addAll({'telephone': telephone});
    result.addAll({'address': address});
    result.addAll({'birthday': birthday.toString()});
    result.addAll({'allergy': allergy});
    result.addAll({'useOfImage': useOfImage});
    result.addAll({'active': active});
    result.addAll({'dateCreate': dateCreate.toString()});

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'] ?? '',
      crew: Crew.fromMap(map['crew']),
      mother: map['mother'],
      father: map['father'],
      schoolName: map['schoolName'],
      schoolGrade: map['schoolGrade'],
      telephone: map['telephone'],
      address: map['address'],
      birthday: DateTime.parse(map['birthday']),
      allergy: map['allergy'],
      useOfImage: map['useOfImage'],
      active: map['active'],
      dateCreate: DateTime.parse(map['dateCreate']),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Student.fromJson(Map<String, dynamic> source) =>
      Student.fromMap(source);
}
