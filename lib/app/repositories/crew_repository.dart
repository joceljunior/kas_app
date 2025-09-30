import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/repositories/interfaces/i_crew_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CrewRepository implements ICrewRepository {
  final Dio httpService = GetIt.instance<Dio>();

  @override
  Future<List<Crew>> getCrews() async {
    try {
      print('DEBUG getCrews - Starting query for crews...');

      // Primeiro, vamos tentar buscar todas as turmas (sem filtro de active)
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('Crew'))
            ..orderByAscending('Name');

      final ParseResponse response = await parseQuery.query();

      print('DEBUG getCrews - Response success: ${response.success}');
      print('DEBUG getCrews - Response count: ${response.count}');
      print('DEBUG getCrews - Response error: ${response.error}');

      if (response.success && response.results != null) {
        var obj = response.results!.map((e) => Crew.fromJson(e)).toList();
        print('DEBUG getCrews - Found ${obj.length} crews');

        // Filtrar apenas turmas ativas (se o campo existir) ou todas (se não existir)
        var activeCrews = obj.where((crew) => crew.active != false).toList();
        print('DEBUG getCrews - Active crews: ${activeCrews.length}');

        return activeCrews;
      }
      return [];
    } catch (e) {
      print('DEBUG getCrews - Exception: $e');
      throw Exception('Erro ao buscar turmas: $e');
    }
  }

  @override
  Future<List<Crew>> getCrewsByTeacher({required String teacherId}) async {
    try {
      print('DEBUG getCrewsByTeacher - Starting query for teacher: $teacherId');

      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('Crew'))
            ..whereEqualTo('teacherId', teacherId)
            ..orderByAscending('Name');

      final ParseResponse response = await parseQuery.query();

      print('DEBUG getCrewsByTeacher - Response success: ${response.success}');
      print('DEBUG getCrewsByTeacher - Response count: ${response.count}');

      if (response.success && response.results != null) {
        var obj = response.results!.map((e) => Crew.fromJson(e)).toList();
        print(
            'DEBUG getCrewsByTeacher - Found ${obj.length} crews for teacher');

        // Filtrar apenas turmas ativas
        var activeCrews = obj.where((crew) => crew.active != false).toList();
        print('DEBUG getCrewsByTeacher - Active crews: ${activeCrews.length}');

        return activeCrews;
      }
      return [];
    } catch (e) {
      print('DEBUG getCrewsByTeacher - Exception: $e');
      throw Exception('Erro ao buscar turmas da professora: $e');
    }
  }

  @override
  Future<bool> postCrew({required Crew crew}) async {
    try {
      var backendCrew = ParseObject('Crew');
      backendCrew.set('Name', crew.name);
      backendCrew.set('Key', crew.key);
      if (crew.teacherId != null) {
        backendCrew.set('teacherId', crew.teacherId);
      }
      if (crew.teacherName != null) {
        backendCrew.set('teacherName', crew.teacherName);
      }
      backendCrew.set('active', crew.active ?? true);
      await backendCrew.save();

      return true;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateCrew({required Crew crewEdit}) async {
    try {
      var backendCrew = ParseObject('Crew');
      backendCrew.set('objectId', crewEdit.id);
      backendCrew.set('Name', crewEdit.name);
      backendCrew.set('Key', crewEdit.key);
      if (crewEdit.teacherId != null) {
        backendCrew.set('teacherId', crewEdit.teacherId);
      }
      if (crewEdit.teacherName != null) {
        backendCrew.set('teacherName', crewEdit.teacherName);
      }
      backendCrew.set('active', crewEdit.active ?? true);
      await backendCrew.update();

      return true;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> getTotalCrew() async {
    try {
      print('DEBUG getTotalCrew - Starting query for total crews...');

      final QueryBuilder<ParseObject> totalCrew =
          QueryBuilder<ParseObject>(ParseObject('Crew'));

      final ParseResponse response = await totalCrew.query();

      print('DEBUG getTotalCrew - Response success: ${response.success}');
      print('DEBUG getTotalCrew - Response count: ${response.count}');

      if (response.success && response.results != null) {
        // Contar apenas turmas ativas
        var obj = response.results!.map((e) => Crew.fromJson(e)).toList();
        var activeCrews = obj.where((crew) => crew.active != false).toList();
        print('DEBUG getTotalCrew - Total active crews: ${activeCrews.length}');
        return activeCrews.length;
      } else {
        return 0;
      }
    } catch (e) {
      print('DEBUG getTotalCrew - Exception: $e');
      throw Exception('Erro ao buscar total de turmas: $e');
    }
  }

  // Método para garantir que todas as turmas tenham o campo 'active'
  Future<void> ensureActiveFieldExists() async {
    try {
      print(
          'DEBUG ensureActiveFieldExists - Ensuring all crews have active field...');

      // Buscar todas as turmas
      final QueryBuilder<ParseObject> query =
          QueryBuilder<ParseObject>(ParseObject('Crew'));

      final ParseResponse response = await query.query();

      if (response.success && response.results != null) {
        int updatedCount = 0;

        for (var crew in response.results!) {
          // Verificar se o campo 'active' não existe ou é null
          if (crew.get('active') == null) {
            // Definir 'active' como true para turmas que não têm esse campo
            crew.set('active', true);
            await crew.save();
            updatedCount++;
          }
        }

        print(
            'DEBUG ensureActiveFieldExists - Updated $updatedCount crews with active field');
      } else {
        print(
            'DEBUG ensureActiveFieldExists - No crews found or error occurred');
      }
    } catch (e) {
      print('DEBUG ensureActiveFieldExists - Error ensuring active field: $e');
    }
  }
}
