import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/I_crew_controller.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/core/errors/kas_error.dart';
import 'package:mobx/mobx.dart';

part 'crew_list_store.g.dart';

// This is the class used by rest of your codebase
class CrewListStore = _CrewListStore with _$CrewListStore;

// The store-class
abstract class _CrewListStore with Store {
  final ICrewController controller = GetIt.I<ICrewController>();

  @observable
  bool loading = true;

  @observable
  List<Crew> crews = [];

  @observable
  String? messageError;

  @action
  Future<void> getCrews() async {
    try {
      loading = true;
      var result = await controller.getCrews();
      crews = result;
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
