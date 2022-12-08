import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/models/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/user.dart';

class LoginController implements ILoginController {
  final ILoginRepository repository = GetIt.instance<ILoginRepository>();
  @override
  Future<User> login({required User user}) async {
    try {
      var result = await repository.login(user: user);
      return result;
    } catch (e) {
      throw Exception();
    }
  }
}
