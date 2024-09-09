import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/view/crew/store/crew_states.dart';
import 'package:kas_app/core/errors/kas_error.dart';

import '../../../controllers/interfaces/i_student_controller.dart';

// This is the class used by rest of your codebase
class CrewStudentsListStore extends ValueNotifier<CrewState> {
  CrewStudentsListStore() : super(CrewInitialState());
  final IStudentController controller = GetIt.I<IStudentController>();

  Future<void> getStudentsByCrew({required String idCrew}) async {
    try {
      value = CrewLoadingState();
      var result = await controller.getStudentsByCrew(idCrew: idCrew);
      value = CrewListStudentSuccessState(students: result);
    } on StudentError catch (e) {
      value = CrewErrorState(message: e.message);
    } catch (e) {
      String messageError = "Ocorreu um erro desconhecido";
      value = CrewErrorState(message: messageError);
    }
  }
}
