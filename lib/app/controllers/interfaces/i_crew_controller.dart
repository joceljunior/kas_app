import 'package:kas_app/app/models/crew.dart';

abstract class ICrewController {
  Future<List<Crew>> getCrews();
  Future<bool> postOrPutCrew({required bool isEdit, required Crew crew});
}
