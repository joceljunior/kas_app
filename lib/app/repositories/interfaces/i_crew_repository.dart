import 'package:kas_app/app/models/crew.dart';

abstract class ICrewRepository {
  Future<List<Crew>> getCrews();
  Future<List<Crew>> getCrewsByTeacher({required String teacherId});
  Future<int> getTotalCrew();
  Future<bool> postCrew({required Crew crew});
  Future<bool> updateCrew({required Crew crewEdit});
  Future<void> ensureActiveFieldExists(); // Método para garantir campo active
}
