import 'package:kas_app/app/models/crew.dart';

abstract class ICrewController {
  Future<List<Crew>> getCrews();
  Future<List<Crew>> getCrewsByTeacher({required String teacherId});
  Future<int> getTotalCrew();
  Future<bool> postOrPutCrew({required bool isEdit, required Crew crew});
  Future<void> ensureActiveFieldExists(); // Método para garantir campo active
}
