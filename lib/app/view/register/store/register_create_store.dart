import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/kas_error.dart';

part 'register_create_store.g.dart';

// This is the class used by rest of your codebase
class RegisterCreateStore = _RegisterCreateStore with _$RegisterCreateStore;

// The store-class
abstract class _RegisterCreateStore with Store {
  final IStudentController controller = GetIt.I<IStudentController>();
  final IRegisterController controllerRegister = GetIt.I<IRegisterController>();

  final TextEditingController justificationController = TextEditingController();
  bool register = false;
  DateTime? dateReference;

  @observable
  bool loading = false;

  @observable
  List<Student> students = [];

  @observable
  String? messageError;

  @action
  Future<void> getStudents({required int idCrew}) async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controller.getStudentsByCrew(idCrew: idCrew);
      students = result;
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
  Future<void> postRegister() async {
    try {
      loading = true;
      await Future.delayed(Duration(seconds: 1));
      var result = await controllerRegister.postRegister(
          studentsRegister: students, dateCreate: dateReference!);

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
