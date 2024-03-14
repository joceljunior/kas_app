import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_crew_controller.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/view/crew/store/crew_states.dart';
import 'package:kas_app/core/errors/kas_error.dart';

// This is the class used by rest of your codebase
class CrewCreateStore extends ValueNotifier<CrewState> {
  CrewCreateStore() : super(CrewInitialState());
  final ICrewController controller = GetIt.I<ICrewController>();

  final TextEditingController nameCrewController = TextEditingController();
  final TextEditingController idCrewController = TextEditingController();
  bool isEdit = false;

  Future<void> createCrew({required bool isEdit, required Crew crew}) async {
    try {
      value = CrewLoadingState();
      await controller.postOrPutCrew(isEdit: isEdit, crew: crew);
      value = CrewSuccessState();
    } catch (e) {}
  }
}
