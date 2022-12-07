import 'package:flutter/material.dart';

abstract class IKasRouter {
  void navigation({
    required BuildContext context,
    required String screen,
  });
}
