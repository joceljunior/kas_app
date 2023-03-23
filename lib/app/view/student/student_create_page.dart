import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../models/crew.dart';
import '../../models/student.dart';
import 'store/student_create_store.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/textformfield_widget.dart';

class StudentCreatePage extends StatefulWidget {
  final Student? studentEdit;
  const StudentCreatePage({
    super.key,
    this.studentEdit,
  });

  @override
  State<StudentCreatePage> createState() => _StudentCreatePageState();
}

class _StudentCreatePageState extends State<StudentCreatePage> {
  final StudentCreateStore store = StudentCreateStore();

  @override
  void initState() {
    store.getCrews(studentEdit: widget.studentEdit);

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 185, 207),
        elevation: 5,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
        title: Text(
          "Cadastro de Turma",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Observer(builder: (_) {
        if (store.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextFormFieldWidget(
                          hintText: "Nome",
                          controller: store.nameStudentController),
                      TextFormFieldWidget(
                          hintText: "Mãe", controller: store.motherController),
                      TextFormFieldWidget(
                          hintText: "Pai", controller: store.fatherController),
                      TextFormFieldWidget(
                          hintText: "Endereço",
                          controller: store.addressController),
                      TextFormFieldWidget(
                          hintText: "Telefone",
                          controller: store.telephoneController),
                      TextFormFieldWidget(
                          hintText: "Escola",
                          controller: store.schoolNameController),
                      TextFormFieldWidget(
                          hintText: "Ano Escolar",
                          controller: store.schoolGradeController),
                      TextFormFieldWidget(
                          hintText: "Possui alguma Alergia?",
                          controller: store.allergyController),
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.008),
                        child: SizedBox(
                          width: size.width,
                          child: DropdownButton<Crew>(
                            hint: Text("Selecione uma Turma"),
                            value: store.crewInitial,
                            items: store.itensDropDown,
                            onChanged: (newValue) {
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
                              onChanged: (value) {
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
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
                      paddingVertical: 0,
                      click: () async {
                        var student = Student(
                            id: store.isEdit ? widget.studentEdit!.id : null,
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
                            schoolGrade: store.schoolGradeController.text);

                        await store.createStudent(
                          isEdit: store.isEdit,
                          student: student,
                        );

                        if (store.success) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}