import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/models/student.dart';

abstract class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final List<Student> students;

  RegisterSuccessState({required this.students});
}

class RegisterListSuccessState extends RegisterState {
  final List<Register> registers;

  RegisterListSuccessState({required this.registers});
}

class RegisterErrorState extends RegisterState {}
