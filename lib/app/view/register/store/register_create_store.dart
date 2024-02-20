import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_register_controller.dart';
import 'package:kas_app/app/controllers/interfaces/i_student_controller.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/student.dart';
import 'package:kas_app/app/models/student_register.dart';
import 'package:kas_app/app/view/register/states/register_states.dart';
import '../../../../core/errors/kas_error.dart';

class RegisterCreateStore extends ValueNotifier<RegisterState> {
  RegisterCreateStore() : super(RegisterLoadingState());

  final IStudentController controllerStudent = GetIt.I<IStudentController>();
  final IRegisterController controllerRegister = GetIt.I<IRegisterController>();

  final TextEditingController justificationController = TextEditingController();
  bool isEdit = false;
  bool register = false;
  DateTime? dateReference;
  bool loading = false;
  List<StudentRegister> studentsRegisters = [];
  List<Student> students = [];
  String? messageError;

  Future<void> getStudents({required String idCrew}) async {
    try {
      value = RegisterLoadingState();
      await Future.delayed(Duration(seconds: 1));
      var result = await controllerStudent.getStudentsByCrew(idCrew: idCrew);

      students = result;
      value = RegisterSuccessState();
    } catch (e) {
      value = RegisterErrorState();
      messageError = "Ocorreu um erro desconhecido";
    }
  }

  // Future<void> getStudentsToEdit({required Register register}) async {
  //   try {
  //     loading = true;
  //     isEdit = true;
  //     dateReference = register.dateRegister;
  //     await Future.delayed(Duration(seconds: 1));
  //     var result = await controllerStudent.getStudentsByRegister(
  //         idCrew: register.registers.first.crewId, dateRegister: register.date);
  //     for (var students in result) {
  //       var item =
  //           register.registers.where((y) => y.studentId == students.id).first;
  //       students.isRegister = item.participation;
  //       students.justification = item.justification;
  //     }
  //     students = result;
  //     loading = false;
  //   } on StudentError catch (e) {
  //     loading = false;
  //     messageError = e.message;
  //   } catch (e) {
  //     loading = false;
  //     messageError = "Ocorreu um erro desconhecido";
  //   }
  // }

  Future<void> postRegister({required String crewId}) async {
    try {
      value = RegisterLoadingState();
      students.forEach((element) {
        var studentRegister = StudentRegister(
            participation: element.isRegister,
            studentId: element.id!,
            justification: element.justification);
        studentsRegisters.add(studentRegister);
      });

      await controllerRegister.postRegister(
        studentsRegister: studentsRegisters,
        dateRegister: dateReference!,
        isEdit: isEdit,
        crewId: crewId,
      );

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
