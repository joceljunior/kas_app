import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_crew_controller.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/repositories/interfaces/i_crew_repository.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class CrewController implements ICrewController {
  final ICrewRepository repository = GetIt.instance<ICrewRepository>();

  @override
  Future<List<Crew>> getCrews() async {
    try {
      var result = await repository.getCrews();

      if (result.isEmpty) {
        throw CrewError(message: "Nenhuma turma cadastrada!");
      }
      return result;
    } on CrewError catch (e) {
      throw CrewError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postOrPutCrew({required bool isEdit, required Crew crew}) async {
    try {
      var result = false;
      if (isEdit) {
        result = await repository.updateCrew(crewEdit: crew);
      } else {
        result = await repository.postCrew(crew: crew);
      }

      return result;
    } on CrewError catch (e) {
      throw CrewError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> getTotalCrew() async {
    try {
      var result = await repository.getTotalCrew();
      return result;
    } on CrewError catch (e) {
      throw CrewError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }
}
