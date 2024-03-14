import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_student_repository.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../core/errors/kas_error.dart';

class StudentRpository implements IStudentRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<bool> deleteStudent({required String id}) async {
    try {
      var backendStudent = ParseObject('Student');
      backendStudent.set('objectId', id);
      backendStudent.set('active', false); // Define o aluno como inativo
      await backendStudent.update();
      return true;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudents({int page = 1, int pageSize = 10}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('Student'))
            ..whereEqualTo('active', true);
      // ..setAmountToSkip((page - 1) * pageSize)
      // ..setLimit(pageSize);

      final ParseResponse response = await parseQuery.query();

      if (response.success) {
        var students =
            response.results!.map((e) => Student.fromJson(e)).toList();

        // Buscar as turmas vinculadas para cada aluno
        for (var student in students) {
          final QueryBuilder<ParseObject> studentCrewsQuery =
              QueryBuilder<ParseObject>(ParseObject('StudentCrews'))
                ..whereEqualTo('studentId', student.id);

          final ParseResponse crewResponse = await studentCrewsQuery.query();

          if (crewResponse.success) {
            List<String> crewIds = crewResponse.results!
                .map<String>((crew) => crew['crewId'] as String)
                .toList();

            student.crews = crewIds;
          }
        }

        return students;
      }
      return [];
    } catch (e) {
      // print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<bool> postStudent(
      {required Student student, required List<String> crews}) async {
    try {
      // // Enviar a foto para o Back4App e obter o URL da foto
      // final ParseFile parseFile = ParseFile(student.photo);
      // final ParseResponse fileResponse = await parseFile.save();

      // if (!fileResponse.success) {
      //   throw Exception('Erro ao enviar a foto');
      // }

      // final String photoUrl = fileResponse.result['url'];

      var backendStudent = ParseObject('Student');
      backendStudent.set('name', student.name);
      // backendStudent.set('photo', null);
      backendStudent.set('schoolName', student.schoolName);
      backendStudent.set('schoolGrade', student.schoolGrade);
      backendStudent.set('telephone', student.telephone);
      backendStudent.set('address', student.address);
      backendStudent.set('addressNumber', int.parse(student.addressNumber));
      backendStudent.set('complement', student.complement);
      backendStudent.set('addressDistrict', student.addressDistrict);
      backendStudent.set('addressCity', student.addressCity);
      backendStudent.set('birthday', student.birthday);
      backendStudent.set('allergy', student.allergy);
      backendStudent.set('useImage', student.useImage);
      backendStudent.set('active', student.active);
      backendStudent.set('dateRegistry', student.dateregistry);
      backendStudent.set('cpf', student.cpf);
      backendStudent.set('nameResponsible', student.responsible);
      backendStudent.set('relationship', student.relationship);
      backendStudent.set('nationality', student.nationality);
      var result = await backendStudent.save();

      for (String crew in crews) {
        ParseObject backendStudentCrews = ParseObject('StudentCrews')
          ..set('studentId',
              backendStudent.objectId) // Referência ao objectId do aluno
          ..set('crewId', crew); // Referência ao objectId da turma
        await backendStudentCrews.save();
      }

      return true;
    } on Exception catch (e) {
      throw CrewError(message: e.toString());
    }
  }

  @override
  Future<bool> updateStudent(
      {required Student studentEdit, required List<String> crews}) async {
    try {
      var backendStudent = ParseObject('Student');
      backendStudent.set('objectId', studentEdit.id);
      backendStudent.set('name', studentEdit.name);
      backendStudent.set('schoolName', studentEdit.schoolName);
      backendStudent.set('schoolGrade', studentEdit.schoolGrade);
      backendStudent.set('telephone', studentEdit.telephone);
      backendStudent.set('address', studentEdit.address);
      backendStudent.set('addressNumber', int.parse(studentEdit.addressNumber));
      backendStudent.set('addressDistrict', studentEdit.addressDistrict);
      backendStudent.set('addressCity', studentEdit.addressCity);
      backendStudent.set('birthday', studentEdit.birthday);
      backendStudent.set('allergy', studentEdit.allergy);
      backendStudent.set('useImage', studentEdit.useImage);
      backendStudent.set('active', studentEdit.active);
      backendStudent.set('dateRegistry', studentEdit.dateregistry);
      backendStudent.set('cpf', studentEdit.cpf);
      backendStudent.set('nameResponsible', studentEdit.responsible);
      backendStudent.set('relationship', studentEdit.relationship);
      backendStudent.set('nationality', studentEdit.nationality);
      await backendStudent.save();

      await _deleteStudentCrews(studentEdit.id!);

      await _addStudentCrews(studentEdit.id!, crews);

      return true;
    } on Exception catch (e) {
      throw CrewError(message: e.toString());
    }
  }

  @override
  Future<List<Student>> getStudentsByCrew({required String idCrew}) async {
    try {
      // Consulta para buscar os alunos associados à turma especificada
      final QueryBuilder<ParseObject> studentCrewsQuery =
          QueryBuilder<ParseObject>(ParseObject('StudentCrews'))
            ..whereEqualTo('crewId', idCrew);

      final ParseResponse crewResponse = await studentCrewsQuery.query();

      if (crewResponse.success) {
        // Lista para armazenar os IDs dos alunos associados à turma
        List<String> studentIds = crewResponse.results!
            .map<String>((crew) => crew['studentId'] as String)
            .toList();

        // Consulta para buscar os alunos ativos pelo ID
        final QueryBuilder<ParseObject> activeStudentsQuery =
            QueryBuilder<ParseObject>(ParseObject('Student'))
              ..whereContainedIn('objectId',
                  studentIds) // Filtra pelos IDs dos alunos associados à turma
              ..whereEqualTo('active', true); // Filtra apenas os alunos ativos

        final ParseResponse studentsResponse =
            await activeStudentsQuery.query();

        if (studentsResponse.success) {
          // Mapeia os resultados para objetos Student
          List<Student> activeStudents = studentsResponse.results!
              .map((e) => Student.fromJson(e))
              .toList();

          return activeStudents;
        }
      }
      return [];
    } catch (e) {
      // print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<Student> getStudentsById({required String idStudent}) async {
    try {
      final QueryBuilder<ParseObject> studentsQuery =
          QueryBuilder<ParseObject>(ParseObject('Student'))
            ..whereEqualTo('objectId', idStudent);
      final ParseResponse response = await studentsQuery.query();

      if (response.success &&
          response.results != null &&
          response.results!.isNotEmpty) {
        return Student.fromJson(response.results!.first);
      } else {
        throw Exception('Nenhum aluno encontrado com o ID especificado');
      }
    } catch (e) {
      throw Exception('Erro ao buscar aluno por ID: $e');
    }
  }

  @override
  Future<int> getTotalStudent() async {
    try {
      final QueryBuilder<ParseObject> activeStudentsQuery =
          QueryBuilder<ParseObject>(ParseObject('Student'))
            ..whereEqualTo('active', true); // Filtra apenas os alunos ativos

      final ParseResponse response = await activeStudentsQuery.query();

      if (response.success) {
        // Retorna o número de resultados (total de alunos ativos)
        return response.count;
      } else {
        return 0; // Retorna 0 se não houver alunos ativos
      }
    } catch (e) {
      // print(e.toString());
      throw Exception();
    }
  }

  Future<void> _deleteStudentCrews(String studentId) async {
    final QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject('StudentCrews'))
          ..whereEqualTo('studentId', studentId);

    try {
      final ParseResponse response = await queryBuilder.query();

      if (response.success && response.results != null) {
        for (final ParseObject parseObject in response.results!) {
          await parseObject.delete();
        }
      }
    } catch (e) {
      throw Exception('Erro ao excluir associações de turma: $e');
    }
  }

  Future<void> _addStudentCrews(String studentId, List<String> crews) async {
    for (String crew in crews) {
      ParseObject backendStudentCrews = ParseObject('StudentCrews')
        ..set('studentId', studentId)
        ..set('crewId', crew);
      await backendStudentCrews.save();
    }
  }
}
