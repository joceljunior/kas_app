import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/kas_error.dart';
import '../../../controllers/interfaces/i_student_controller.dart';
import '../../../models/student.dart';

part 'crew_students_list_store.g.dart';

// This is the class used by rest of your codebase
class CrewStudentsListStore = _CrewStudentsListStore
    with _$CrewStudentsListStore;

// The store-class
abstract class _CrewStudentsListStore with Store {
  final IStudentController controller = GetIt.I<IStudentController>();

  @observable
  bool loading = true;

  @observable
  List<Student> students = [];

  @observable
  String? messageError;

  @action
  Future<void> getStudentsByCrew({required int idCrew}) async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controller.getStudentsByCrew(idCrew: idCrew);
      students = result;
      loading = false;
    } on CrewError catch (e) {
      loading = false;
      messageError = e.message;
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }
}
