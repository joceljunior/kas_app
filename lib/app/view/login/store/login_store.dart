import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';
import 'package:kas_app/app/view/login/store/login_state.dart';
import 'package:kas_app/core/database/entity/session.dart';
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
  @observable
  LoginState state = LoginStateInitial();
  @observable
  Session session = Session();

  @action
  Future<void> login({required User user}) async {
    try {
      state = LoginStateLoading();
      var result = await controller.login(user: user);
      session = result;
      state = LoginStateSuccess();
    } catch (e) {
      state = LoginStateError();
    }
  }
}
