import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/I_crew_controller.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/models/interfaces/i_crew_repository.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class CrewController implements ICrewController {
  final ICrewRepository repository = GetIt.instance<ICrewRepository>();

  @override
  Future<List<Crew>> getCrews() async {
    try {
      var result = await repository.getCrews();
      return result;
    } on CrewError catch (e) {
      throw CrewError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postCrew({required Crew crew}) async {
    try {
      var result = await repository.postCrew(crew: crew);
      return result;
    } on CrewError catch (e) {
      throw CrewError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateCrew({required Crew crewEdit}) {
    // TODO: implement updateCrew
    throw UnimplementedError();
  }
}
