import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:mobx/mobx.dart';

import 'student_states.dart';

// This is the class used by rest of your codebase
class StudentListStore extends ValueNotifier<StudentState> {
  StudentListStore() : super(StudentListLoadingState());
  final IStudentController controller = GetIt.I<IStudentController>();

  bool loading = false;
  List<Student> students = [];
  String? messageError;

  Future<void> getStudents() async {
    try {
      value = StudentListLoadingState();
      var result = await controller.getStudents();
      value = StudentListSuccessState(students: result);
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }

  @action
  Future<void> deleteStudent({required String id}) async {
    try {
      value = StudentListLoadingState();
      await controller.deleteStudent(id: id);
      value = StudentDeleteSuccessState();
    } catch (e) {
      loading = false;
      messageError = "Ocorreu um erro desconhecido";
    }
  }
}
