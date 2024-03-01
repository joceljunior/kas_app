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
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('Crew'));

      final ParseResponse response = await parseQuery.query();

      if (response.success) {
        var obj = response.results!.map((e) => Crew.fromJson(e)).toList();
        return obj;
      }
      return [];
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postCrew({required Crew crew}) async {
    try {
      var backendCrew = ParseObject('Crew');
      backendCrew.set('Name', crew.name);
      backendCrew.set('Key', crew.key);
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
      await backendCrew.update();

      return true;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> getTotalCrew() async {
    try {
      final QueryBuilder<ParseObject> totalCrew =
          QueryBuilder<ParseObject>(ParseObject('Crew'));

      final ParseResponse response = await totalCrew.query();

      if (response.success) {
        return response.count;
      } else {
        return 0;
      }
    } catch (e) {
      // print(e.toString());
      throw Exception();
    }
  }
}
