import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/core/database/entity/session.dart';

abstract class ILoginController {
  Future<Session> login({required User user});
}
