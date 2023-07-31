// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/models/register_crew.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/app/view/crew/crew_create_page.dart';
import 'package:kas_app/app/view/crew/crew_list_page.dart';
import 'package:kas_app/app/view/crew/crew_students_list_page.dart';
import 'package:kas_app/app/view/home/home_page.dart';
import 'package:kas_app/app/view/login/login_page.dart';
import 'package:kas_app/app/view/register/register_create_page.dart';
import 'package:kas_app/app/view/register/register_list_page.dart';
import 'package:kas_app/app/view/student/student_create_page.dart';
import 'package:kas_app/app/view/student/student_list_page.dart';
import 'package:kas_app/core/database/interface/i_database.dart';
import 'package:kas_app/core/utils/params_enum.dart';

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
              session == null ? LoginPage() : HomePage(session: session),
        );

      case homePage:
        var session = db.getStorage("session");
        return MaterialPageRoute(
          builder: (_) => HomePage(
            session: session,
          ),
        );

      case crewListPage:
        var data = args as ParamsEnum;
        return MaterialPageRoute(
          builder: (_) => CrewListPage(
            typePage: data,
          ),
        );

      case registerListPage:
        var crew = args as Crew;
        return MaterialPageRoute(
          builder: (_) => RegisterListPage(
            crew: crew,
          ),
        );

      case registerCreatePage:
        var register = args as RegisterCrew;
        return MaterialPageRoute(
          builder: (_) => RegisterCreatePage(
            registerCrew: register,
          ),
        );

      case crewCreatePage:
        var crew = args == null ? null : args as Crew;
        return MaterialPageRoute(
          builder: (_) => CrewCreatePage(
            crewEdit: crew,
          ),
        );

      case studentListPage:
        return MaterialPageRoute(
          builder: (_) => StudentListPage(),
        );

      case studentCreatePage:
        var student = args == null ? null : args as Student;
        return MaterialPageRoute(
          builder: (_) => StudentCreatePage(
            studentEdit: student,
          ),
        );
      case crewStudentsListPage:
        var crew = args as Crew;
        return MaterialPageRoute(
          builder: (_) => CrewStudentsListPage(
            crew: crew,
          ),
        );
      default:
        // pagina de erro
        String url = settings.name == null ? "" : settings.name!;
        var student = args == null ? null : args as Student;
        var list = url.split('/');
        var crewId = list.length > 2 ? int.parse(list[2]) : null;
        return MaterialPageRoute(
          builder: (_) => StudentCreatePage(
            studentEdit: student,
            crewId: crewId,
          ),
        );
    }
  }
}
