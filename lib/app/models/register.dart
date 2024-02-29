import 'package:kas_app/app/models/student_register.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Register {
  String? id;
  String crewId;
  List<StudentRegister> studentRegisters;
  DateTime dateRegister;

  Register({
    this.id,
    required this.crewId,
    required this.studentRegisters,
    required this.dateRegister,
  });

  Map<String, dynamic> toMap() {
    return {
      'crewId': crewId,
      'studentRegisters': studentRegisters
          .map((studentRegister) => studentRegister.toMap())
          .toList(),
      'dateRegister': dateRegister,
    };
  }

  factory Register.fromMap(ParseObject map) {
    return Register(
      id: map['objectId'],
      crewId: map['crewId'],
      studentRegisters: (map['studentRegisters'] as List)
          .map((studentMap) => StudentRegister.fromMap(studentMap))
          .toList(),
      dateRegister: map['dateregister'],
    );
  }

  factory Register.fromJson(ParseObject source) => Register.fromMap(source);
}
