import '../../../models/user.dart';

abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  final User user;
  LoginStateSuccess({
    required this.user,
  });
}

class LoginStateError extends LoginState {}
