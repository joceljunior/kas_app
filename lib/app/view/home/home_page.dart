import 'package:flutter/material.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/utils/params_enum.dart';

import '../../../core/database/boxes/session.dart';
import '../../../core/widgets/appbar_widget.dart';
import '../../../core/widgets/background_base_widget.dart';
import 'widget/button_menu_widget.dart';

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
        child: BackgoundBaseWidget(
          size: size.height,
          child: Column(
            children: [
              AppBarWidget(userName: session.nameUSer!),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    ButtonMenuWidget(
                        icon: Icons.list,
                        title: 'Chamadas',
                        ontap: () {
                          Navigator.of(context).pushNamed(
                            crewListPage,
                            arguments: ParamsEnum.register,
                          );
                        }),
                    ButtonMenuWidget(
                        icon: Icons.group,
                        title: 'Turmas',
                        ontap: () {
                          Navigator.of(context).pushNamed(
                            crewListPage,
                            arguments: ParamsEnum.crew,
                          );
                        }),
                    ButtonMenuWidget(
                        icon: Icons.school_outlined,
                        title: 'Alunos',
                        ontap: () {
                          Navigator.of(context).pushNamed(studentListPage,
                              arguments: ParamsEnum.student);
                        }),
                    ButtonMenuWidget(
                        icon: Icons.dashboard,
                        title: 'Relatórios',
                        ontap: () {}),
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
