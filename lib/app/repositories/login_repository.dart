import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/core/constants/urls.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class LoginRepository implements ILoginRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<User> login({required User user}) async {
    try {
      var json = user.toJson();
      var result = await httpService.post(loginPostUrl, data: json);
      var obj = User.fromMap(result.data);
      return obj;
    } on DioError catch (e) {
      var message = e.response!.data['message'];
      throw LoginError(message: message);
    } catch (e) {
      throw Exception();
    }
  }
}
