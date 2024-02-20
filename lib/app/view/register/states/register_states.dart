import 'package:kas_app/app/models/register.dart';

abstract class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterListSuccessState extends RegisterState {
  final List<Register> registers;

  RegisterListSuccessState({required this.registers});
}

class RegisterErrorState extends RegisterState {}
