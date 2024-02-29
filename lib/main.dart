import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kas_app/app/view/app_widget.dart';
import 'package:kas_app/core/database/boxes/session.dart';
import 'package:kas_app/core/services/service_locator.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'x0glFszYc9puGSYr1ODyza7Qej1PkGiEwM7VAj6Y';
  const keyClientKey = 'ZumqURJep4l4ui2tAkcoZ3aTEJHJJbJXf4j8U3DW';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  // usePathUrlStrategy();
  ServiceLocator.setup();
  Hive.registerAdapter<Session>(SessionAdapter());
  await Hive.initFlutter();

  await Hive.openBox('session');
  runApp(AppWidget());
}
