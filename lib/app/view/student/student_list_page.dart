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
  bool _isLoadingMore = false;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    store.getStudents();
    scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    scrollController
        .dispose(); // Lembre-se de descartar o controlador quando não for mais necessário
    super.dispose();
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
          print(state);
          if (state is StudentCreateErrorState) {
            return Center(
              child: Text('Houve um problema'),
            );
          }
          if (state is StudentListLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              controller: scrollController,
              itemCount: store.students.length +
                  1, // Adicione 1 para o indicador de carregamento
              itemBuilder: (context, index) {
                if (index < store.students.length) {
                  var student = store.students[index];
                  return StudentItemWidget(
                    student: student,
                    onTapDelete: () async {
                      await showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: Text(
                              "Voce esta inativando este aluno! Deseja continuar ?",
                            ),
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
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancelar"),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    onTapEdit: () async {
                      await Navigator.of(context)
                          .pushNamed(studentCreatePage, arguments: student)
                          .then((value) {
                        store.getStudents();
                      });
                    },
                  );
                } else if (state is StudentListLoadingMoreState) {
                  return Center(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()),
                  );
                } else {
                  return Container(); // Se não estiver carregando mais dados, retorne um contêiner vazio
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    final double maxScroll = scrollController.position.maxScrollExtent;
    final double currentScroll = scrollController.position.pixels;
    if (currentScroll == maxScroll && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      store.getMoreStudents().then((_) {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }
}
