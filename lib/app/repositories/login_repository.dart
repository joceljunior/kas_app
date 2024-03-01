import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginRepository implements ILoginRepository {
  final Dio httpService = GetIt.instance<Dio>();
  @override
  Future<User> login({required User user}) async {
    try {
      final userSys = ParseUser(user.username, user.password, null);

      var response = await userSys.login();

      if (response.success) {
        user.id = userSys.objectId;
        user.role = userSys.get('Role');
        return user;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
