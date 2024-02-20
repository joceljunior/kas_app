import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kas_app/app/models/register.dart';
import 'package:kas_app/app/view/register/store/register_create_store.dart';
import 'package:kas_app/app/view/register/widgets/student_register_item_widget.dart';
import 'package:kas_app/core/widgets/button_widget.dart';

import '../../../core/widgets/textformfield_widget.dart';

class RegisterCreatePage extends StatefulWidget {
  final String crewId;
  const RegisterCreatePage({
    super.key,
    required this.crewId,
  });

  @override
  State<RegisterCreatePage> createState() => _RegisterCreatePageState();
}

class _RegisterCreatePageState extends State<RegisterCreatePage> {
  final RegisterCreateStore store = RegisterCreateStore();

  @override
  void initState() {
    // widget.register != null
    //     ? store.getStudentsToEdit(register: widget.register)
    //     :
    store.getStudents(idCrew: widget.crewId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crie uma chamada",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 246, 185, 207),
        elevation: 5,
        toolbarHeight: size.height * 0.2,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: store,
          builder: (_, state, child) {
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
                            return StudentRegisterItemWidget(
                              student: student,
                              ontapParticipation: (bool value) {
                                setState(() {
                                  student.isRegister = value;
                                });
                              },
                              ontapJustification: () async {
                                store.justificationController.clear();
                                if (student.justification != null) {
                                  store.justificationController.text =
                                      student.justification!;
                                }
                                await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: TextFormFieldWidget(
                                          hintText:
                                              'Adicione uma justificativa',
                                          controller:
                                              store.justificationController,
                                          maxLines: 5,
                                          validator: (String? value) => value,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (store
                                                          .justificationController
                                                          .text !=
                                                      "") {
                                                    student.justification = store
                                                        .justificationController
                                                        .text;
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Text("Confirma"),
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red)),
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
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height * 0.01),
                      child: ButtonWidget(
                        textButton: "Salvar",
                        width: size.width,
                        height: size.height * 0.08,
                        click: () async {
                          store.dateReference = await showDatePicker(
                            helpText: "SELECIONE A DATA DA CHAMADA",
                            context: context,
                            initialDate: store.isEdit
                                ? store.dateReference!
                                : DateTime.now(),
                            firstDate: DateTime(2000, 01, 01),
                            lastDate: DateTime(3000, 31, 12),
                          );
                          if (store.dateReference != null) {
                            await store.postRegister(crewId: widget.crewId);
                            Navigator.of(context).pop();
                          }
                        },
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
