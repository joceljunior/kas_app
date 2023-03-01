// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/view/crew/crew_create_page.dart';
import 'package:kas_app/app/view/crew/crew_list_page.dart';
import 'package:kas_app/app/view/home/home_page.dart';
import 'package:kas_app/app/view/login/login_page.dart';
import 'package:kas_app/app/view/splash/splash_page.dart';
import 'package:kas_app/core/database/interface/i_database.dart';

import '../constants/routes.dart';

class KasRouter {
  final IDatabase db = GetIt.I<IDatabase>();
  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case initialRoute:
        var session = db.getStorage("session");
        return MaterialPageRoute(
          builder: (_) =>
              session == null ? SplashPage() : HomePage(session: session),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );

      case homePage:
        var session = db.getStorage("session");
        return MaterialPageRoute(
          builder: (_) => HomePage(
            session: session,
          ),
        );
      case crewListPage:
        return MaterialPageRoute(
          builder: (_) => CrewListPage(),
        );
      case crewCreatePage:
        return MaterialPageRoute(
          builder: (_) => CrewCreatePage(),
        );
      default:
        // pagina de erro
        return MaterialPageRoute(
          builder: (context) => SplashPage(),
        );
    }
  }
}
