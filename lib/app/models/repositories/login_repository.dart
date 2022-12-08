import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/models/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/core/constants/urls.dart';

class LoginRepository implements ILoginRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<User> login({required User user}) async {
    try {
      var json = user.toJson();
      var result = await httpService.post(loginPostUrl, data: json);
      var obj = User.fromMap(result.data);
      return obj;
    } catch (e) {
      throw Exception();
    }
  }
}
