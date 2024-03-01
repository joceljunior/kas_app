import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/app/models/student_register.dart';
import 'package:kas_app/app/view/register/states/register_states.dart';

class RegisterCreateStore extends ValueNotifier<RegisterState> {
  RegisterCreateStore() : super(RegisterLoadingState());

  final IStudentController controllerStudent = GetIt.I<IStudentController>();
  final IRegisterController controllerRegister = GetIt.I<IRegisterController>();

  final TextEditingController justificationController = TextEditingController();
  DateTime? dateRegister;
  bool isEdit = false;
  List<StudentRegister> studentsRegisters = [];
  List<Student> students = [];

  Future<void> getStudents({required String idCrew}) async {
    try {
      value = RegisterLoadingState();
      isEdit = false;
      await Future.delayed(Duration(seconds: 1));
      var result = await controllerStudent.getStudentsByCrew(idCrew: idCrew);
      students = result;

      value = RegisterSuccessState(students: result);
    } catch (e) {
      value = RegisterErrorState();
    }
  }

  Future<void> getStudentsToEdit({required Register register}) async {
    try {
      value = RegisterLoadingState();
      isEdit = true;
      students = [];
      for (var element in register.studentRegisters) {
        var result = await controllerStudent.getStudentsById(
            idStudent: element.studentId);
        result.isRegister = element.participation;
        result.justification = element.justification;
        students.add(result);
      }
      value = RegisterSuccessState(students: students);
    } catch (e) {
      value = RegisterErrorState();
    }
  }

  Future<void> postRegister({required String crewId}) async {
    try {
      value = RegisterLoadingState();
      for (var element in students) {
        var studentRegister = StudentRegister(
            participation: element.isRegister,
            studentId: element.id!,
            justification: element.justification);
        studentsRegisters.add(studentRegister);
      }

      await controllerRegister.postRegister(
        studentsRegister: studentsRegisters,
        dateRegister: dateRegister!,
        isEdit: false,
        crewId: crewId,
      );
    } catch (e) {
      value = RegisterErrorState();
    }
  }
}
