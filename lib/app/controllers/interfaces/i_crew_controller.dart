import '../../models/crew.dart';

abstract class ICrewController {
  Future<List<Crew>> getCrews();
  Future<bool> postCrew({required Crew crew});
  Future<bool> updateCrew({required Crew crewEdit});
}
