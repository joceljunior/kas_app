import 'package:kas_app/app/models/crew.dart';

abstract class ICrewRepository {
  Future<List<Crew>> getCrews();
  Future<int> getTotalCrew();
  Future<bool> postCrew({required Crew crew});
  Future<bool> updateCrew({required Crew crewEdit});
}
