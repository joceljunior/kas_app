// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/student.dart';

import 'student_states.dart';

// This is the class used by rest of your codebase
class StudentListStore extends ValueNotifier<StudentState> {
  StudentListStore() : super(StudentListLoadingState());
  final IStudentController controller = GetIt.I<IStudentController>();
  int currentPage = 1;
  int pageSize = 15;
  List<Student> students = [];
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController =
      TextEditingController(); // Controlador para o campo de pesquisa

  Future<void> getStudents() async {
    try {
      value = StudentListLoadingState();
      var result =
          await controller.getStudents(page: currentPage, pageSize: pageSize);
      students = result;
      value = StudentListSuccessState(students: result);
    } catch (e) {}
  }

  Future<void> getMoreStudents() async {
    try {
      currentPage++;
      value = StudentListLoadingMoreState();
      var result =
          await controller.getStudents(page: currentPage, pageSize: pageSize);

      if (result.isEmpty) {
        value = StudentListCompleteState();
      }

      var existingStudents = List.of(students);
      existingStudents.addAll(result);
      students = existingStudents;
      value = StudentListSuccessState(students: existingStudents);
    } catch (e) {
      // Trate o erro de forma apropriada, por exemplo, definindo o estado para erro
      // value = StudentListErrorState();
    }
  }

  Future<void> searchStudents() async {
    try {
      value = StudentListLoadingState();
      var result =
          await controller.searchStudents(query: searchController.text);
      students = result;
      value = StudentListSuccessState(students: result);
    } catch (e) {}
  }

  Future<void> deleteStudent({required String id}) async {
    try {
      value = StudentListLoadingState();
      await controller.deleteStudent(id: id);
      value = StudentDeleteSuccessState();
    } catch (e) {}
  }
}
