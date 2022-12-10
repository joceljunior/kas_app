import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/view/home/widget/button_menu_widget.dart';

import 'package:kas_app/core/database/interface/i_database.dart';
import 'package:kas_app/core/database/entity/session.dart';
import 'package:kas_app/core/widgets/appbar_widget.dart';
import 'package:kas_app/core/widgets/background_base_widget.dart';

class HomePage extends StatelessWidget {
  final Session session;
  HomePage({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 228, 241),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              AppBarWidget(
                  height: size.height * 0.25, userName: session.nameUSer!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    ButtonMenuWidget(),
                    ButtonMenuWidget(),
                    ButtonMenuWidget(),
                    ButtonMenuWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
