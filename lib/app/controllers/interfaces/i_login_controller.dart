import '../../models/user.dart';

abstract class ILoginController {
  Future<User> login({required User user});
}
