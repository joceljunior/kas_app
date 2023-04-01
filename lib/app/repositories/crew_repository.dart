import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/repositories/interfaces/i_crew_repository.dart';
import 'package:kas_app/core/errors/kas_error.dart';

import '../../core/constants/urls.dart';

class CrewRepository implements ICrewRepository {
  final Dio httpService = GetIt.instance<Dio>();

  @override
  Future<List<Crew>> getCrews() async {
    try {
      var url = crewGetUrl;
      var result = await httpService.get(url);
      var obj = (result.data as List).map((e) => Crew.fromJson(e)).toList();
      return obj;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw CrewError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postCrew({required Crew crew}) async {
    try {
      var json = crew.toJson();
      await httpService.post(crewPostUrl, data: json);

      return true;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw CrewError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateCrew({required Crew crewEdit}) async {
    try {
      var json = crewEdit.toJson();
      await httpService.put(crewPuttUrl, data: json);

      return true;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw CrewError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> getTotalCrew() async {
    try {
      var result = await httpService.get(crewTotalGetUrl);
      var total = result.data;
      return total;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw CrewError(message: message);
    } catch (e) {
      throw Exception();
    }
  }
}
