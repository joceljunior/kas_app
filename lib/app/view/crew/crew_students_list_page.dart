import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kas_app/core/constants/routes.dart';

import '../../models/crew.dart';
import 'store/crew_students_list_store.dart';
import 'widgets/student_crew_item_widget.dart';

class CrewStudentsListPage extends StatefulWidget {
  final Crew crew;
  const CrewStudentsListPage({
    super.key,
    required this.crew,
  });

  @override
  State<CrewStudentsListPage> createState() => _CrewStudentsListPageState();
}

class _CrewStudentsListPageState extends State<CrewStudentsListPage> {
  final CrewStudentsListStore store = CrewStudentsListStore();

  @override
  void initState() {
    store.getStudentsByCrew(idCrew: widget.crew.id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.crew.name,
              style: TextStyle(color: Colors.black),
            ),
            Observer(
              builder: (_) {
                if (store.loading) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            store.students.length.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Text(
                          "alunos",
                          style: TextStyle(color: Colors.black38, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
        backgroundColor: Color.fromARGB(255, 246, 185, 207),
        elevation: 5,
        toolbarHeight: size.height * 0.2,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
      ),
      body: Observer(builder: (_) {
        if (store.messageError != null) {
          return Center(
            child: Text(store.messageError!),
          );
        }

        if (store.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.67,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: store.students.length,
                      itemBuilder: (context, index) {
                        var student = store.students[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                                studentCreatePage,
                                arguments: student);
                          },
                          child: StudentCrewItemWidget(
                            student: student,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
