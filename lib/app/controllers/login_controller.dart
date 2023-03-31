import 'package:get_it/get_it.dart';

import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/repositories/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/core/database/boxes/session.dart';
import 'package:kas_app/core/database/interface/i_database.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class LoginController implements ILoginController {
  final ILoginRepository repository = GetIt.instance<ILoginRepository>();
  final IDatabase db = GetIt.instance<IDatabase>();

  @override
  Future<Session> login({required User user}) async {
    try {
      var result = await repository.login(user: user);
      var session = Session(
        idUSer: result.id,
        nameUSer: result.username,
        passwordUser: result.password,
        roleUser: result.role,
      );
      await db.saveStorage(session);
      return session;
    } on LoginError catch (e) {
      throw LoginError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future logout() async {
    try {
      await db.deleteStorage("session");
    } on LoginError catch (e) {
      throw LoginError(message: e.message);
    } catch (e) {
      throw Exception();
    }
  }
}
