import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/controllers/login_controller.dart';
import 'package:kas_app/app/models/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/repositories/login_repository.dart';
import 'package:kas_app/core/database/interface/i_database.dart';
import 'package:kas_app/core/routes/interfaces/i_kas_router.dart';
import 'package:kas_app/core/routes/kas_router.dart';

import '../database/database.dart';

class ServiceLocator {
  static void setup() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<IKasRouter>(KasRouter());
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<IDatabase>(Database());
    getIt.registerSingleton<ILoginRepository>(LoginRepository());
    getIt.registerSingleton<ILoginController>(LoginController());
  }
}
