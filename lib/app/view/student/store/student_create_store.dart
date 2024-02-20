// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_crew_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/app/view/student/store/student_states.dart';
import 'package:kas_app/core/errors/kas_error.dart';

import '../../../models/crew.dart';

class StudentCreateStore extends ValueNotifier<StudentState> {
  StudentCreateStore() : super(StudentCreateLoadingState());

  final IStudentController controller = GetIt.I<IStudentController>();
  final ICrewController controllerCrew = GetIt.I<ICrewController>();

  final TextEditingController nameStudentController = TextEditingController();
  final TextEditingController responsibleController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController schoolGradeController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressNumberController = TextEditingController();
  final TextEditingController addressCityController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController addressDistrictController =
      TextEditingController();
  final TextEditingController allergyController = TextEditingController();
  final TextEditingController dateCreateController = TextEditingController();
  final TextEditingController dateBirthdayController = TextEditingController();
  bool useOfImageController = true;
  bool activeController = true;
  DateTime dateCreate = DateTime.now(); // 28/03/2020
  DateTime dateBirthday = DateTime.now(); // 28/03/2020
  Crew? crewInitial;
  String typeSponsorSelected = '';
  bool isEdit = false;

  List<Crew> crews = [];
  List<String> selectedCrews = [];

  Future<void> createStudent(
      {required bool isEdit, required Student student}) async {
    try {
      value = StudentCreateLoadingState();
      isEdit
          ? await controller.updateStudent(
              studentEdit: student, crews: selectedCrews)
          : await controller.postStudent(
              student: student, crews: selectedCrews);
      value = StudentCreateSuccessState();
    } on StudentError catch (e) {
      value = StudentCreateErrorState(message: e.message);
    } catch (e) {
      value = StudentCreateErrorState(message: 'Ocorreu um erro');
    }
  }

  Future<void> getCrews({Student? studentEdit}) async {
    try {
      value = StudentCreateLoadingState();
      await Future.delayed(Duration(seconds: 1));
      var result = await controllerCrew.getCrews();
      crews = result;
      selectedCrews = studentEdit != null ? studentEdit.crews! : [];
      value = StudentCreateSuccessState();
    } on CrewError catch (e) {
      value = StudentCreateErrorState(message: e.message);
    } catch (e) {
      value = StudentCreateErrorState(message: 'Ocorreu um erro');
    }
  }
}
