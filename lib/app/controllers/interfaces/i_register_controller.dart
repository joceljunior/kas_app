import 'package:kas_app/app/models/student.dart';

import '../../models/register.dart';

abstract class IRegisterController {
  Future<bool> postRegister(
      {required List<Student> studentsRegister, required DateTime dateCreate});
  Future<List<Register>> getRegisterByCrew({required int idCrew});
}
