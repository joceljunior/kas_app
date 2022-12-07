import 'package:flutter/material.dart';
import 'package:kas_app/app/view/app_widget.dart';
import 'package:kas_app/core/services/service_locator.dart';

void main() {
  ServiceLocator.setup();
  runApp(AppWidget());
}
