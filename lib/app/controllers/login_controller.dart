import 'package:get_it/get_it.dart';

import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/models/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/core/database/entity/session.dart';
import 'package:kas_app/core/database/interface/i_database.dart';

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
      await db.create(session);
      return session;
    } catch (e) {
      throw Exception();
    }
  }
}
