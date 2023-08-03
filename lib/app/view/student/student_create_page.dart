import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kas_app/core/constants/routes.dart';
import '../../models/crew.dart';
import '../../models/student.dart';
import 'store/student_create_store.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/textformfield_widget.dart';

class StudentCreatePage extends StatefulWidget {
  final Student? studentEdit;
  final int? crewId;
  const StudentCreatePage({
    super.key,
    this.studentEdit,
    this.crewId,
  });

  @override
  State<StudentCreatePage> createState() => _StudentCreatePageState();
}

class _StudentCreatePageState extends State<StudentCreatePage> {
  final StudentCreateStore store = StudentCreateStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    store.getCrews(studentEdit: widget.studentEdit, crewId: widget.crewId);

    if (widget.studentEdit != null) {
      store.isEdit = true;
      store.activeController = widget.studentEdit!.active;
      store.addressController.text = widget.studentEdit!.address;
      store.allergyController.text = widget.studentEdit!.allergy;
      store.nameStudentController.text = widget.studentEdit!.name;
      store.schoolNameController.text = widget.studentEdit!.schoolName;
      store.schoolGradeController.text = widget.studentEdit!.schoolGrade == null
          ? ""
          : widget.studentEdit!.schoolGrade!;
      store.bithdayController = widget.studentEdit!.birthday;
      store.dateCreateController = widget.studentEdit!.dateCreate;
      store.motherController.text = widget.studentEdit!.mother;
      store.fatherController.text = widget.studentEdit!.father;
      store.activeController = widget.studentEdit!.active;
      store.useOfImageController = widget.studentEdit!.useOfImage;
      store.telephoneController.text = widget.studentEdit!.telephone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.crewId != null) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 246, 185, 207),
          elevation: 5,
          automaticallyImplyLeading: false,
          leading: widget.crewId == null
              ? GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black),
                )
              : null,
          title: Text(
            "Cadastro Aluno",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Observer(builder: (_) {
          if (store.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  color: Colors.white10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextFormFieldWidget(
                            hintText: "Nome",
                            controller: store.nameStudentController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Nome do aluno é obrigatório";
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Mãe",
                            controller: store.motherController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Nome da mãe é obrigatório";
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Pai",
                            controller: store.fatherController,
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Endereço",
                            controller: store.addressController,
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Telefone",
                            controller: store.telephoneController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Telefone é obrigatório";
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Escola",
                            controller: store.schoolNameController,
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Ano Escolar",
                            controller: store.schoolGradeController,
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hintText: "Possui alguma Alergia?",
                            controller: store.allergyController,
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.height * 0.008),
                            child: SizedBox(
                              width: size.width,
                              child: DropdownButton<Crew>(
                                hint: Text("Selecione uma Turma"),
                                value: store.crewInitial,
                                items: store.itensDropDown,
                                onChanged: widget.crewId != null
                                    ? null
                                    : (newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            store.crewInitial = newValue;
                                          });
                                        }
                                      },
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: store.useOfImageController,
                                  onChanged: (value) {
                                    setState(() {
                                      store.useOfImageController = value!;
                                    });
                                  }),
                              Text("Autorizo o uso de imagem")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: store.activeController,
                                  onChanged: widget.crewId != null
                                      ? null
                                      : (value) {
                                          setState(() {
                                            store.activeController = value!;
                                          });
                                        }),
                              Text("Ativo")
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  color: Colors.blue,
                                  icon: Icon(Icons.calendar_month),
                                  onPressed: () async {
                                    var selectDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1990, 1, 1),
                                      lastDate: DateTime(2090, 1, 1),
                                    );
                                    if (selectDate != null) {
                                      setState(() {
                                        store.bithdayController = selectDate;
                                      });
                                    }
                                  }),
                              Text("Aniversário"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                  "${store.bithdayController.day}/${store.bithdayController.month}/${store.bithdayController.year}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                color: Colors.blue,
                                icon: Icon(Icons.calendar_month),
                                onPressed: () async {
                                  var selectDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000, 1, 1),
                                    lastDate: DateTime(2090, 1, 1),
                                  );
                                  if (selectDate != null) {
                                    setState(() {
                                      store.dateCreateController = selectDate;
                                    });
                                  }
                                },
                              ),
                              Text("Data Criação"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                  "${store.dateCreateController.day}/${store.dateCreateController.month}/${store.dateCreateController.year}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: ButtonWidget(
                          textButton: "Salvar",
                          width: size.width,
                          height: size.height * 0.08,
                          click: () async {
                            if (_formKey.currentState!.validate()) {
                              var student = Student(
                                  id: store.isEdit
                                      ? widget.studentEdit!.id
                                      : null,
                                  active: store.activeController,
                                  address: store.addressController.text,
                                  allergy: store.allergyController.text,
                                  birthday: store.bithdayController,
                                  crew: store.crewInitial!,
                                  dateCreate: store.dateCreateController,
                                  father: store.fatherController.text,
                                  mother: store.motherController.text,
                                  name: store.nameStudentController.text,
                                  schoolName: store.schoolNameController.text,
                                  telephone: store.telephoneController.text,
                                  useOfImage: store.useOfImageController,
                                  schoolGrade:
                                      store.schoolGradeController.text);

                              await store.createStudent(
                                isEdit: store.isEdit,
                                student: student,
                              );

                              if (widget.crewId != null) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    createStudentSuccess, (route) => false);
                              }

                              if (store.success && widget.crewId == null) {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
