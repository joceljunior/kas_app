import '../../models/student.dart';

abstract class IStudentController {
  Future<List<Student>> getStudents();
  Future<int> getTotalStudent();
  Future<List<Student>> getStudentsByCrew({required String idCrew});
  Future<List<Student>> getStudentsByRegister(
      {required DateTime dateRegister, required String idCrew});
  Future<bool> postStudent({required Student student});
  Future<bool> updateStudent({required Student studentEdit});
  Future<bool> deleteStudent({required String id});
}
