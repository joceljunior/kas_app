import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_register_repository.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RegisterRepository implements IRegisterRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<List<Register>> getRegisterByCrew({required String idCrew}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('Register'))
            ..whereEqualTo('crewId', idCrew);

      final ParseResponse response = await parseQuery.query();

      if (response.success) {
        var obj = response.results!.map((e) => Register.fromJson(e)).toList();
        return obj;
      }
      return [];
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postRegister(
      {required Register register, required bool isEdit}) async {
    try {
      var backendRegister = ParseObject('Register');
      backendRegister.set('crewId', register.crewId);
      List<Map<String, dynamic>> studentRegistersData = register
          .studentRegisters
          .map((studentRegister) => studentRegister.toMap())
          .toList();
      backendRegister.set('studentRegisters', studentRegistersData);
      backendRegister.set('dateregister', register.dateRegister);
      await backendRegister.save();

      return true;
    } catch (e) {
      throw Exception();
    }
  }
}
