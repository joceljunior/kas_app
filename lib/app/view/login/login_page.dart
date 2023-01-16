// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/app/view/login/store/login_store.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/routes/interfaces/i_kas_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/background_base_widget.dart';
import '../../../core/widgets/button_widget.dart';
import 'widgets/form_login_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginStore store = LoginStore();
  IKasRouter router = GetIt.I<IKasRouter>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: store.scaffoldKey,
      body: Observer(
        builder: (_) {
          return ModalProgressHUD(
            inAsyncCall: store.loading,
            child: SingleChildScrollView(
              child: BackgoundBaseWidget(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      logoSplash,
                      height: size.height * 0.3,
                    ),
                    Center(
                      child: FormLoginWidget(
                        passwordController: store.passwordController,
                        usernameController: store.usernameController,
                        size: size,
                        buttonLogin: ButtonWidget(
                          width: size.width * 0.77,
                          height: size.height * 0.08,
                          paddingVertical: size.height * 0.08,
                          click: () async {
                            var user = User(
                              username: store.usernameController.text,
                              password: store.passwordController.text,
                            );

                            await store.login(user: user);
                            if (store.session != null) {
                              router.navigation(
                                context: context,
                                screen: homePage,
                                args: store.session,
                              );
                            } else {
                              store.usernameController.clear();
                              store.passwordController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(store.messageError),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                size: size.height,
              ),
            ),
          );
        },
      ),
    );
  }
}
