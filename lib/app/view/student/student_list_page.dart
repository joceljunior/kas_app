import 'package:flutter/material.dart';
import 'package:kas_app/app/view/student/store/student_states.dart';
import 'package:kas_app/core/constants/routes.dart';

import 'store/student_list_store.dart';
import 'widgets/student_item_widget.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final StudentListStore store = StudentListStore();
  @override
  void initState() {
    store.getStudents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alunos",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 246, 185, 207),
        elevation: 5,
        toolbarHeight: size.height * 0.2,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.blue[200],
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(studentCreatePage)
                    .then((value) {
                  store.getStudents();
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: store,
          builder: (context, state, child) {
            if (state is StudentCreateErrorState) {
              return Center(
                child: Text(store.messageError!),
              );
            }
            if (state is StudentListLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is StudentListSuccessState) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.students.length,
                  itemBuilder: (context, index) {
                    var student = state.students[index];
                    return StudentItemWidget(
                      student: student,
                      onTapDelete: () async {
                        await showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                content: Text(
                                    "Voce esta inativando este aluno! Deseja continuar ?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          store.deleteStudent(id: student.id!);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Confirma"),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancelar"),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                      onTapEdit: () async {
                        await Navigator.of(context)
                            .pushNamed(studentCreatePage, arguments: student)
                            .then((value) {
                          store.getStudents();
                        });
                      },
                    );
                  },
                ),
              );
            }
            return Container();
          }),
    );
  }
}
