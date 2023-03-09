import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/interfaces/i_student_repository.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class StudentController implements IStudentController {
  final IStudentRepository repository = GetIt.I<IStudentRepository>();
  @override
  Future<bool> deleteStudent({required int id}) async {
    try {
      var result = await repository.deleteStudent(id: id);
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudents() async {
    try {
      var result = await repository.getStudents();
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postStudent({required Student student}) async {
    try {
      var result = await repository.postStudent(student: student);
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateStudent({required Student studentEdit}) async {
    try {
      var result = await repository.updateStudent(studentEdit: studentEdit);
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }
}
