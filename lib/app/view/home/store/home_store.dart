// ignore_for_file: unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:mobx/mobx.dart';

import '../../../controllers/interfaces/i_crew_controller.dart';

// Include generated file
part 'home_store.g.dart';

// This is the class used by rest of your codebase
class HomeStore = _HomeStore with _$HomeStore;

// The store-class
abstract class _HomeStore with Store {
  final IStudentController controllerStudent =
      GetIt.instance<IStudentController>();
  final ICrewController controllerCrew = GetIt.instance<ICrewController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  bool loading = false;
  @observable
  int? crewTotal;
  @observable
  int? studentTotal;

  @action
  Future<void> getTotals() async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 3));
      studentTotal = await controllerStudent.getTotalStudent();
      crewTotal = await controllerCrew.getTotalCrew();
      loading = false;
    } catch (e) {
      loading = false;
      studentTotal = -1;
      crewTotal = -1;
    }
  }
}
