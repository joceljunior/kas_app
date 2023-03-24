import 'package:kas_app/app/models/register_crew.dart';
import 'package:kas_app/app/models/student.dart';

abstract class IRegisterController {
  Future<bool> postRegister({
    required List<Student> studentsRegister,
    required DateTime dateCreate,
    required bool isEdit,
    required int crewId,
  });
  Future<List<RegisterCrew>> getRegisterByCrew({required int idCrew});
}
