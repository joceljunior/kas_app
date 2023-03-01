import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kas_app/app/controllers/crew_controller.dart';
import 'package:kas_app/app/controllers/interfaces/I_crew_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/controllers/login_controller.dart';
import 'package:kas_app/app/models/interfaces/i_crew_repository.dart';
import 'package:kas_app/app/models/interfaces/i_login_repository.dart';
import 'package:kas_app/app/models/repositories/crew_repository.dart';
import 'package:kas_app/app/models/repositories/login_repository.dart';
import 'package:kas_app/core/database/interface/i_database.dart';

import '../database/database.dart';

class ServiceLocator {
  static void setup() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerLazySingleton<HiveInterface>(() => Hive);
    getIt.registerSingleton<IDatabase>(Database());
    getIt.registerSingleton<ILoginRepository>(LoginRepository());
    getIt.registerSingleton<ILoginController>(LoginController());
    getIt.registerSingleton<ICrewRepository>(CrewRepository());
    getIt.registerSingleton<ICrewController>(CrewController());
  }
}
