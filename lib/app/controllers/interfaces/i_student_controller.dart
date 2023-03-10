import '../../models/student.dart';

abstract class IStudentController {
  Future<List<Student>> getStudents();
  Future<List<Student>> getStudentsByCrew({required int idCrew});
  Future<bool> postStudent({required Student student});
  Future<bool> updateStudent({required Student studentEdit});
  Future<bool> deleteStudent({required int id});
}
