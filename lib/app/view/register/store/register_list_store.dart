import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/register_crew.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/kas_error.dart';
import '../../../models/register.dart';

part 'register_list_store.g.dart';

// This is the class used by rest of your codebase
class RegisterListStore = _RegisterListStore with _$RegisterListStore;

// The store-class
abstract class _RegisterListStore with Store {
  final IRegisterController controller = GetIt.I<IRegisterController>();
  DateTime? dateReference;

  @observable
  bool loading = false;

  @observable
  List<RegisterCrew> registers = [];

  @observable
  String? messageError;

  @action
  Future<void> getRegister({required int idCrew}) async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controller.getRegisterByCrew(idCrew: idCrew);
      registers = result;
      loading = false;
    } on StudentError catch (e) {
      loading = false;
      messageError = e.message;
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }
}
