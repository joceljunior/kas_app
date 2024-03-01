import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/student_register.dart';

abstract class IRegisterController {
  Future<bool> postRegister({
    required List<StudentRegister> studentsRegister,
    required DateTime dateRegister,
    required bool isEdit,
    required String crewId,
  });
  Future<bool> updateRegister({
    required List<StudentRegister> studentsRegister,
    required DateTime dateRegister,
    required bool isEdit,
    required String crewId,
  });
  Future<List<Register>> getRegisterByCrew({required String idCrew});
}
