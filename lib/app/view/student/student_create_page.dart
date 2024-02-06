import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:kas_app/core/constants/routes.dart';
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
      store.dateCreateController = widget.studentEdit!.dateregistry;
      store.responsibleController.text = widget.studentEdit!.responsible;
      store.activeController = widget.studentEdit!.active;
      store.useOfImageController = widget.studentEdit!.useImage;
      store.telephoneController.text = widget.studentEdit!.telephone;
    }

    super.initState();
  }

  String formatDate(String input) {
    try {
      final dateTime = DateFormat('dd/MM/yyyy').parse(input);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      // Caso a entrada não seja uma data válida, você pode retornar a entrada original ou uma mensagem de erro.
      return input;
    }
  }

  @override
  Widget build(BuildContext context) {
    store.dateController.addListener(() {
      final text = store.dateController.text;

      if (text.length == 2 || text.length == 5) {
        store.dateController.text = text + '/';
        store.dateController.selection =
            TextSelection.collapsed(offset: text.length + 1);
      }
    });
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: Color.fromARGB(26, 170, 168, 168),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            //informações da aluna
                            Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.task_alt_sharp,
                                            color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text(
                                          'Informações da Aluna(o)',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 207, 203, 203),
                                      ),
                                      child: Icon(Icons.person_2_outlined,
                                          size: size.height * 0.08),
                                    ),
                                    SizedBox(height: 5),
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
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Nome do aluno é obrigatório";
                                        }
                                        return null;
                                      },
                                      controller: store.dateController,
                                      keyboardType: TextInputType.datetime,
                                      hintText: 'Data de Nascimento',
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
                                      hintText: "Nacionalidade",
                                      controller: store.nationalityController,
                                      validator: (String? value) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //informações do responsavel
                            Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.task_alt_sharp,
                                            color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text(
                                          'Informações do Responsável',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    ExpansionTile(
                                      title: Text('Tipo de Responsável'),
                                      children: store.itensSponsor,
                                    ),
                                    TextFormFieldWidget(
                                      hintText: "Nome do Responsável",
                                      controller: store.responsibleController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Nome do responsável é obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormFieldWidget(
                                      hintText: "CPF",
                                      controller: store.cpfController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "CPF é obrigatório";
                                        }
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
                                  ],
                                ),
                              ),
                            ),

                            Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.task_alt_sharp,
                                            color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text(
                                          'Informações de Endereço',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    TextFormFieldWidget(
                                      hintText: "Rua",
                                      controller: store.addressStreetController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Rua é obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormFieldWidget(
                                      hintText: "Número",
                                      controller: store.addressNumberController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Numero é obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormFieldWidget(
                                      hintText: "Bairro",
                                      controller:
                                          store.addressDistrictController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Telefone é obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormFieldWidget(
                                      hintText: "Cidade",
                                      controller: store.addressCityController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Telefone é obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.task_alt_sharp,
                                            color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text(
                                          'Informações Adicionais',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    TextFormFieldWidget(
                                      hintText:
                                          "Possui alguma Alergia ou Restrição Alimentar?",
                                      controller: store.allergyController,
                                      validator: (String? value) {
                                        return null;
                                      },
                                    ),
                                    TextFormFieldWidget(
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Data de registro é obrigatório";
                                        }
                                        return null;
                                      },
                                      controller: store.dateController,
                                      keyboardType: TextInputType.datetime,
                                      hintText: 'Data do Registro',
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: store.useOfImageController,
                                            onChanged: (value) {
                                              setState(() {
                                                store.useOfImageController =
                                                    value!;
                                              });
                                            }),
                                        Text(
                                          "AUTORIZO O USO DE IMAGEM",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: Text('Turmas'),
                                      children: store.itensCrews,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                    relationship:
                                        store.relationshipController.text,
                                    active: store.activeController,
                                    address: store.addressController.text,
                                    allergy: store.allergyController.text,
                                    birthday: store.bithdayController,
                                    addressCity:
                                        store.addressCityController.text,
                                    addressDistrict:
                                        store.addressDistrictController.text,
                                    addressNumber:
                                        store.addressNumberController.text,
                                    crews: [],
                                    // crew: store.crewInitial!,
                                    dateregistry: store.dateCreateController,
                                    responsible:
                                        store.responsibleController.text,
                                    name: store.nameStudentController.text,
                                    schoolName: store.schoolNameController.text,
                                    telephone: store.telephoneController.text,
                                    useImage: store.useOfImageController,
                                    cpf: store.cpfController.text,
                                    nationality:
                                        store.nationalityController.text,
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
              ),
            );
          }
        }),
      ),
    );
  }
}
