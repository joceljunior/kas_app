import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_register_repository.dart';
import 'package:kas_app/app/models/register.dart';

import '../../core/constants/urls.dart';
import '../../core/errors/kas_error.dart';

class RegisterRepository implements IRegisterRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<List<Register>> getRegisterByCrew({required int idCrew}) async {
    try {
      var url = "$registerGetUrl/$idCrew";
      var result = await httpService.get(url);
      var obj = (result.data as List).map((e) => Register.fromJson(e)).toList();
      return obj;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw RegisterError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postRegister(
      {required List<Register> registers, required bool isEdit}) async {
    try {
      var url = isEdit ? registerPutUrl : registerPostUrl;
      var json = registers.map((i) => i.toJson()).toList().toString();

      isEdit
          ? await httpService.put(url, data: json)
          : await httpService.post(url, data: json);

      return true;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw RegisterError(message: message);
    } catch (e) {
      throw Exception();
    }
  }
}
