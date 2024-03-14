import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_crew_controller.dart';
import 'package:kas_app/app/view/crew/store/crew_states.dart';
import 'package:kas_app/core/errors/kas_error.dart';

class CrewListStore extends ValueNotifier<CrewState> {
  CrewListStore() : super(CrewInitialState());
  final ICrewController controller = GetIt.I<ICrewController>();

  Future<void> getCrews() async {
    try {
      value = CrewLoadingState();
      var result = await controller.getCrews();
      value = CrewListSuccessState(crews: result);
      // ignore: empty_catches
    } catch (e) {
      value = CrewErrorState(message: 'Ocorreu um erro');
    }
  }
}
