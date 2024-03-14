// ignore_for_file: unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/view/login/store/login_states.dart';
import 'package:kas_app/core/database/boxes/session.dart';

import '../../../models/user.dart';

// This is the class used by rest of your codebase
class LoginStore extends ValueNotifier<LoginState> {
  LoginStore() : super(LoginInitialState());
  final ILoginController controller = GetIt.instance<ILoginController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> login({required User user}) async {
    try {
      value = LoginLoadingState();
      var result = await controller.login(user: user);
      value = LoginSuccessState(sesion: result);
    } catch (e) {}
  }
}
