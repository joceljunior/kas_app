import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/repositories/interfaces/i_student_repository.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class StudentController implements IStudentController {
  final IStudentRepository repository = GetIt.I<IStudentRepository>();
  @override
  Future<bool> deleteStudent({required String id}) async {
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
      if (result.isEmpty) {
        throw StudentError(message: "Nenhum aluno cadastrado!");
      }
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postStudent(
      {required Student student, required List<String> crews}) async {
    try {
      var result = await repository.postStudent(student: student, crews: crews);
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateStudent(
      {required Student studentEdit, required List<String> crews}) async {
    try {
      var result = await repository.updateStudent(
          studentEdit: studentEdit, crews: crews);
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudentsByCrew({required String idCrew}) async {
    try {
      var result = await repository.getStudentsByCrew(idCrew: idCrew);
      if (result.isEmpty) {
        throw StudentError(message: "Esta turma não tem alunos cadastrados");
      }
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudentsByRegister(
      {required DateTime dateRegister, required String idCrew}) async {
    try {
      String date =
          "${dateRegister.year}-${dateRegister.month}-${dateRegister.day}";
      var result = await repository.getStudentsByRegister(
          dateRegister: date, idCrew: idCrew);
      if (result.isEmpty) {
        throw StudentError(message: "Esta turma não tem alunos cadastrados");
      }
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> getTotalStudent() async {
    try {
      var result = await repository.getTotalStudent();
      return result;
    } on StudentError catch (e) {
      throw StudentError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }
}
