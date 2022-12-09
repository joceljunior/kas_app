import 'package:flutter/material.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/routes/interfaces/i_kas_router.dart';

class KasRouter implements IKasRouter {
  @override
  void navigation(
      {required BuildContext context, required String screen, Object? args}) {
    switch (screen) {
      case loginPage:
        Navigator.pushNamedAndRemoveUntil(
            context, loginPage, ((route) => false));
        break;
      case homePage:
        Navigator.of(context).pushNamedAndRemoveUntil(
            homePage, ((route) => false),
            arguments: args);
        break;
      default:
    }
  }
}
