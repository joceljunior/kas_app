import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/kas_error.dart';

part 'student_list_store.g.dart';

// This is the class used by rest of your codebase
class StudentListStore = _StudentListStore with _$StudentListStore;

// The store-class
abstract class _StudentListStore with Store {
  final IStudentController controller = GetIt.I<IStudentController>();

  @observable
  bool loading = false;

  @observable
  List<Student> students = [];

  @observable
  String? messageError;

  @action
  Future<void> getStudents() async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controller.getStudents();
      students = result;
      loading = false;
    } on StudentError catch (e) {
      loading = false;
      messageError = e.message;
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }

  @action
  Future<void> deleteStudent({required int id}) async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controller.deleteStudent(id: id);
      getStudents();
    } on StudentError catch (e) {
      loading = false;
      messageError = e.message;
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }
}
