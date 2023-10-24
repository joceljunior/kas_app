// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_crew_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/core/errors/kas_error.dart';
import 'package:mobx/mobx.dart';

import '../../../models/crew.dart';

part 'student_create_store.g.dart';

// This is the class used by rest of your codebase
class StudentCreateStore = _StudentCreateStore with _$StudentCreateStore;

// The store-class
abstract class _StudentCreateStore with Store {
  final IStudentController controller = GetIt.I<IStudentController>();
  final ICrewController controllerCrew = GetIt.I<ICrewController>();

  final TextEditingController nameStudentController = TextEditingController();
  final TextEditingController motherController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController schoolGradeController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController allergyController = TextEditingController();
  bool useOfImageController = true;
  bool activeController = true;
  DateTime dateCreateController = DateTime.now(); // 28/03/2020
  DateTime bithdayController = DateTime.now(); // 28/03/2020
  Crew? crewInitial;
  String? typeSponsor;

  bool isEdit = false;

  @observable
  bool loading = false;

  @observable
  bool success = false;

  @observable
  List<Crew> crews = [];

  @observable
  List<DropdownMenuItem<Crew>> itensDropDown = [];

  @observable
  List<DropdownMenuItem<String>> itensSponsorDropDown = [];

  @observable
  String? messageError;

  @action
  Future<void> createStudent(
      {required bool isEdit, required Student student}) async {
    try {
      loading = true;
      var result = isEdit
          ? await controller.updateStudent(studentEdit: student)
          : await controller.postStudent(student: student);
      success = result;
      loading = false;
    } on StudentError catch (e) {
      loading = false;
      messageError = e.message;
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }

  @action
  Future<void> getCrews({Student? studentEdit, int? crewId}) async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controllerCrew.getCrews();
      crews = result;
      crews.forEach((element) {
        itensDropDown.add(DropdownMenuItem(
          value: element,
          child: Text("${element.name}    -    ${element.key}"),
        ));
      });
      itensSponsorDropDown = [
        DropdownMenuItem(child: Text('Pai'), value: 'Pai'),
        DropdownMenuItem(child: Text('Mãe'), value: 'Mãe'),
        DropdownMenuItem(child: Text('Avo(ó)'), value: 'Avo(ó)'),
        DropdownMenuItem(child: Text('Irmão(a)'), value: 'Irmão(a)'),
        DropdownMenuItem(child: Text('Outro'), value: 'Outro'),
      ];
      if (studentEdit != null) {
        crewInitial =
            crews.firstWhere((element) => element.id == studentEdit.crew.id);
      }
      if (crewId != null) {
        crewInitial = crews.firstWhere((element) => element.id == crewId);
      }
      loading = false;
    } on CrewError catch (e) {
      loading = false;
      messageError = e.message;
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }
}
