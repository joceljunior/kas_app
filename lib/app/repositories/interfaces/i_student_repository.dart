import '../../models/student.dart';

abstract class IStudentRepository {
  Future<List<Student>> getStudents();
  Future<int> getTotalStudent();
  Future<List<Student>> getStudentsByCrew({required String idCrew});
  Future<List<Student>> getStudentsByRegister(
      {required String dateRegister, required String idCrew});
  Future<bool> postStudent(
      {required Student student, required List<String> crews});
  Future<bool> updateStudent(
      {required Student studentEdit, required List<String> crews});
  Future<bool> deleteStudent({required String id});
}
