import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/repositories/interfaces/i_register_repository.dart';
import 'package:kas_app/app/repositories/interfaces/i_student_repository.dart';
import 'package:kas_app/app/repositories/register_repository.dart';
import 'package:kas_app/app/repositories/student_respository.dart';
import '../../app/controllers/crew_controller.dart';
import '../../app/controllers/interfaces/i_crew_controller.dart';
import '../../app/controllers/interfaces/i_login_controller.dart';
import '../../app/controllers/interfaces/i_student_controller.dart';
import '../../app/controllers/login_controller.dart';
import '../../app/controllers/register_controller.dart';
import '../../app/controllers/student_controller.dart';
import '../../app/repositories/interfaces/i_crew_repository.dart';
import '../../app/repositories/interfaces/i_login_repository.dart';
import '../../app/repositories/crew_repository.dart';
import '../../app/repositories/login_repository.dart';
import '../database/interface/i_database.dart';

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
    getIt.registerSingleton<IStudentRepository>(StudentRpository());
    getIt.registerSingleton<IStudentController>(StudentController());
    getIt.registerSingleton<IRegisterRepository>(RegisterRepository());
    getIt.registerSingleton<IRegisterController>(RegisterController());
  }
}
