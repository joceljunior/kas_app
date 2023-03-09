import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_crew_controller.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/core/errors/kas_error.dart';
import 'package:mobx/mobx.dart';

part 'crew_create_store.g.dart';

// This is the class used by rest of your codebase
class CrewCreateStore = _CrewCreateStore with _$CrewCreateStore;

// The store-class
abstract class _CrewCreateStore with Store {
  final ICrewController controller = GetIt.I<ICrewController>();

  final TextEditingController nameCrewController = TextEditingController();
  final TextEditingController idCrewController = TextEditingController();
  bool isEdit = false;

  @observable
  bool loading = false;

  @observable
  bool success = false;

  @observable
  String? messageError;

  @action
  Future<void> createCrew({required bool isEdit, required Crew crew}) async {
    try {
      loading = true;
      var result = await controller.postOrPutCrew(isEdit: isEdit, crew: crew);
      success = result;
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
