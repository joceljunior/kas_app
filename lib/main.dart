import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kas_app/app/view/app_widget.dart';
import 'package:kas_app/core/database/boxes/session.dart';
import 'package:kas_app/core/services/service_locator.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  ServiceLocator.setup();
  Hive.registerAdapter<Session>(SessionAdapter());
  await Hive.initFlutter();

  await Hive.openBox('session');
  runApp(AppWidget());
}
