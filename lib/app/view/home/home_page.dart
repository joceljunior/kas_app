import 'package:flutter/material.dart';
import 'package:kas_app/core/constants/assets.dart';

import '../../../core/database/entity/session.dart';
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
              // AppBarWidget(userName: session.nameUSer!),
              Padding(
                padding: EdgeInsets.all(size.height * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.notification_important_outlined,
                            size: size.height * 0.05,
                          ),
                          Icon(
                            Icons.settings,
                            size: size.height * 0.05,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      logoSplash,
                      height: size.height * 0.2,
                    ),
                    Text(
                      session.nameUSer!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.2,
                          vertical: size.height * 0.002),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('30 Turmas'),
                          Text('206 Alunos'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    ButtonMenuWidget(icon: Icons.list, title: 'Chamadas'),
                    ButtonMenuWidget(icon: Icons.group, title: 'Turmas'),
                    ButtonMenuWidget(
                        icon: Icons.school_outlined, title: 'Alunos'),
                    ButtonMenuWidget(
                        icon: Icons.dashboard, title: 'Relatórios'),
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
