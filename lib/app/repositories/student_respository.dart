import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_student_repository.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/core/constants/urls.dart';

import '../../core/errors/kas_error.dart';

class StudentRpository implements IStudentRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<bool> deleteStudent({required int id}) async {
    try {
      var url = studentDeleteUrl + id.toString();
      await httpService.delete(url);
      return true;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw StudentError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudents() async {
    try {
      var url = studentGetUrl;
      var result = await httpService.get(url);
      var obj = (result.data as List).map((e) => Student.fromJson(e)).toList();
      return obj;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw StudentError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> postStudent({required Student student}) async {
    try {
      var json = student.toJson();
      await httpService.post(studentPostUrl, data: json);

      return true;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw CrewError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateStudent({required Student studentEdit}) async {
    try {
      var json = studentEdit.toJson();
      await httpService.put(studentPuttUrl, data: json);

      return true;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw CrewError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudentsByCrew({required int idCrew}) async {
    try {
      var url = studentsByCrewGetUrl + idCrew.toString();
      var result = await httpService.get(url);
      var obj = (result.data as List).map((e) => Student.fromJson(e)).toList();
      return obj;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw StudentError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Student>> getStudentsByRegister(
      {required String dateRegister, required int idCrew}) async {
    try {
      var url = "$studentsByRegisterGetUrl$dateRegister/$idCrew";
      var result = await httpService.get(url);
      var obj = (result.data as List).map((e) => Student.fromJson(e)).toList();
      return obj;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw StudentError(message: message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> getTotalStudent() async {
    try {
      var result = await httpService.get(studentTotalGetUrl);
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
