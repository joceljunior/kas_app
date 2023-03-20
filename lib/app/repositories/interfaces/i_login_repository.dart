import '../../models/user.dart';

abstract class ILoginRepository {
  Future<User> login({required User user});
}
