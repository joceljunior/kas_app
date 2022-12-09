// ignore_for_file: unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/core/database/entity/session.dart';
import 'package:kas_app/core/errors/kas_error.dart';
import 'package:mobx/mobx.dart';

import '../../../models/user.dart';

// Include generated file
part 'login_store.g.dart';

// This is the class used by rest of your codebase
class LoginStore = _LoginStore with _$LoginStore;

// The store-class
abstract class _LoginStore with Store {
  final ILoginController controller = GetIt.instance<ILoginController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  bool loading = false;
  @observable
  Session? session;
  @observable
  String messageError = '';

  @action
  Future<void> login({required User user}) async {
    try {
      loading = true;
      var result = await controller.login(user: user);
      session = result;
      loading = false;
    } on LoginError catch (e) {
      loading = false;
      session == null;
      messageError = e.message;
    } catch (e) {
      session == null;
    }
  }
}
