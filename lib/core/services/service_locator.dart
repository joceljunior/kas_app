import 'package:get_it/get_it.dart';
import 'package:kas_app/core/interfaces/i_kas_router.dart';
import 'package:kas_app/core/routes/kas_router.dart';

class ServiceLocator {
  static void setup() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<IKasRouter>(KasRouter());
  }
}
