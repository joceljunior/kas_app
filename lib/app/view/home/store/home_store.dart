// ignore_for_file: unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/view/home/states/home_states.dart';

import '../../../controllers/interfaces/i_crew_controller.dart';

class HomeStore extends ValueNotifier<HomeState> {
  HomeStore() : super(HomeStateLoading());
  final IStudentController controllerStudent =
      GetIt.instance<IStudentController>();
  final ICrewController controllerCrew = GetIt.instance<ICrewController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  int? crewTotal;
  int? studentTotal;

  Future<void> getTotals() async {
    try {
      value = HomeStateLoading();

      // Garantir que os campos 'active' existam nas turmas
      print('DEBUG HomeStore - Ensuring active fields exist...');
      await controllerCrew.ensureActiveFieldExists();

      // Executar teste de conexão primeiro
      print('DEBUG HomeStore - Running Back4App connection test...');
      await controllerStudent.testBack4AppConnection();

      // await Future.delayed(Duration(seconds: 3));
      print('DEBUG HomeStore - Getting student total...');
      studentTotal = await controllerStudent.getTotalStudent();
      print('DEBUG HomeStore - Student total received: $studentTotal');

      print('DEBUG HomeStore - Getting crew total...');
      crewTotal = await controllerCrew.getTotalCrew();
      print('DEBUG HomeStore - Crew total received: $crewTotal');

      value = HomeStateSuccess(
          totalStudents: studentTotal ?? 0, totalcrew: crewTotal ?? 0);
      print(
          'DEBUG HomeStore - State updated with totals - Students: ${studentTotal ?? 0}, Crews: ${crewTotal ?? 0}');
    } catch (e) {
      print('DEBUG HomeStore - Error getting totals: $e');
      value = HomeStateError();
    }
  }
}
