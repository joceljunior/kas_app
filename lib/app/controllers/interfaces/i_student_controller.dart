import '../../models/student.dart';

abstract class IStudentController {
  Future<List<Student>> getStudents({int page = 1, int pageSize = 10});
  Future<List<Student>> searchStudents({required String query});
  Future<int> getTotalStudent();
  Future<List<Student>> getStudentsByCrew({required String idCrew});
  Future<Student> getStudentsById({required String idStudent});
  Future<bool> postStudent(
      {required Student student, required List<String> crews});
  Future<bool> updateStudent(
      {required Student studentEdit, required List<String> crews});
  Future<bool> deleteStudent({required String id});
}
