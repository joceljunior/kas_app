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
      // await Future.delayed(Duration(seconds: 3));
      studentTotal = await controllerStudent.getTotalStudent();
      crewTotal = await controllerCrew.getTotalCrew();
      value = HomeStateSuccess(
          totalStudents: studentTotal ?? 0, totalcrew: crewTotal ?? 0);
    } catch (e) {
      value = HomeStateError();
    }
  }
}
