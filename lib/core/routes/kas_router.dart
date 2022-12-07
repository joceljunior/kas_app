import 'package:flutter/material.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/interfaces/i_kas_router.dart';

class KasRouter implements IKasRouter {
  @override
  void navigation({
    required BuildContext context,
    required String screen,
  }) {
    switch (screen) {
      case loginPage:
        Navigator.pushNamedAndRemoveUntil(context, screen, ((route) => false));
        break;
      default:
    }
  }
}
