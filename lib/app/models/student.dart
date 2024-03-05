import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Student {
  final String? id;
  final File? photo;
  final String name;
  List<String>? crews;
  final String responsible;
  final String cpf;
  final String relationship;
  final String nationality;
  final String schoolName;
  final String? schoolGrade;
  final String telephone;
  final String address;
  final String addressNumber;
  final String? complement;
  final String addressDistrict;
  final String addressCity;
  final DateTime birthday;
  final String allergy;
  final bool useImage;
  final bool active;
  final DateTime dateregistry;
  bool isRegister = false;
  String? justification;
  Student({
    this.id,
    required this.name,
    this.photo,
    required this.crews,
    required this.responsible,
    required this.relationship,
    required this.schoolName,
    this.schoolGrade,
    required this.telephone,
    required this.address,
    required this.addressNumber,
    this.complement,
    required this.addressDistrict,
    required this.addressCity,
    required this.birthday,
    required this.cpf,
    required this.allergy,
    required this.useImage,
    required this.active,
    required this.dateregistry,
    required this.nationality,
  });

  factory Student.fromMap(ParseObject map) {
    return Student(
      id: map['objectId'],
      name: map['name'],
      photo: map['photo'],
      relationship: map['relationship'],
      responsible: map['nameResponsible'],
      schoolName: map['schoolName'],
      schoolGrade: map['schoolGrade'],
      telephone: map['telephone'],
      address: map['address'],
      addressDistrict: map['addressDistrict'],
      addressNumber: map['addressNumber'].toString(),
      complement: map['complement'].toString(),
      addressCity: map['addressCity'],
      birthday: map['birthday'],
      allergy: map['allergy'],
      useImage: map['useImage'],
      active: map['active'],
      dateregistry: map['dateRegistry'],
      cpf: map['cpf'].toString(),
      nationality: map['nationality'],
      crews: [],
    );
  }

  factory Student.fromJson(ParseObject source) => Student.fromMap(source);
}
