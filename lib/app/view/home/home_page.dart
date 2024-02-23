import 'package:flutter/material.dart';
import 'package:kas_app/app/view/home/states/home_states.dart';
import 'package:kas_app/app/view/home/store/home_store.dart';
import 'package:kas_app/app/view/home/widget/total_widget.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/utils/params_enum.dart';

import '../../../core/database/boxes/session.dart';
import '../../../core/widgets/appbar_widget.dart';
import '../../../core/widgets/background_base_widget.dart';
import 'widget/button_menu_widget.dart';

class HomePage extends StatefulWidget {
  final Session session;
  HomePage({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = HomeStore();

  @override
  void initState() {
    store.getTotals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 228, 241),
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: (_, state, child) {
          if (state is HomeStateLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomeStateSuccess) {
            return SingleChildScrollView(
              child: BackgoundBaseWidget(
                size: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarWidget(
                      userName: widget.session.nameUSer!,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ButtonMenuWidget(
                            image: 'assets/call.png',
                            title: 'Chamadas',
                            ontap: () async {
                              await Navigator.of(context)
                                  .pushNamed(
                                    crewListPage,
                                    arguments: ParamsEnum.register,
                                  )
                                  .then((value) => store.getTotals());
                            }),
                        ButtonMenuWidget(
                            image: 'assets/crew.png',
                            title: 'Turmas',
                            ontap: () async {
                              await Navigator.of(context)
                                  .pushNamed(
                                    crewListPage,
                                    arguments: ParamsEnum.crew,
                                  )
                                  .then((value) => store.getTotals());
                            }),
                        ButtonMenuWidget(
                            image: 'assets/bailarina.png',
                            title: 'Alunos',
                            ontap: () async {
                              await Navigator.of(context)
                                  .pushNamed(studentListPage,
                                      arguments: ParamsEnum.student)
                                  .then((value) => store.getTotals());
                            }),
                        ButtonMenuWidget(
                            image: 'assets/report.png',
                            title: 'Relatórios',
                            ontap: () {}),
                      ],
                    ),
                    TotalWidget(
                      size: size,
                      crewTotal: state.totalcrew < 0
                          ? "--"
                          : state.totalcrew.toString(),
                      studentTotal: state.totalStudents < 0
                          ? "--"
                          : state.totalStudents.toString(),
                    )
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
