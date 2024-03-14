import 'package:kas_app/core/database/boxes/session.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final Session sesion;

  LoginSuccessState({required this.sesion});
}
