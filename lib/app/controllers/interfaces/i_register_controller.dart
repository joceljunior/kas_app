import 'package:kas_app/app/models/register_crew.dart';
import 'package:kas_app/app/models/student.dart';

import '../../models/register.dart';

abstract class IRegisterController {
  Future<bool> postRegister(
      {required List<Student> studentsRegister, required DateTime dateCreate});
  Future<List<RegisterCrew>> getRegisterByCrew({required int idCrew});
  Future<bool> updateCrew({required Register registerEdit});
  Future<bool> deleteCrew({required int idRegister});
}
