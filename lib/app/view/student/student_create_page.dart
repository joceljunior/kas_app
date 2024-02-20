import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kas_app/app/view/student/store/student_states.dart';
import 'package:kas_app/core/constants/routes.dart';
import '../../models/student.dart';
import 'store/student_create_store.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/textformfield_widget.dart';

class StudentCreatePage extends StatefulWidget {
  final Student? studentEdit;
  final bool? isCreate;
  const StudentCreatePage({
    super.key,
    this.studentEdit,
    this.isCreate,
  });

  @override
  State<StudentCreatePage> createState() => _StudentCreatePageState();
}

class _StudentCreatePageState extends State<StudentCreatePage> {
  final StudentCreateStore store = StudentCreateStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> selectedValues = [];

  @override
  void initState() {
    store.getCrews(studentEdit: widget.studentEdit);

    if (widget.studentEdit != null) {
      store.isEdit = true;
      store.activeController = widget.studentEdit!.active;
      store.addressController.text = widget.studentEdit!.address;
      store.addressCityController.text = widget.studentEdit!.addressCity;
      store.cpfController.text = widget.studentEdit!.cpf;
      store.nationalityController.text = widget.studentEdit!.nationality;
      store.typeSponsorSelected = widget.studentEdit!.relationship;

      store.addressNumberController.text = widget.studentEdit!.addressNumber;
      store.addressDistrictController.text =
          widget.studentEdit!.addressDistrict;
      store.allergyController.text = widget.studentEdit!.allergy;
      store.nameStudentController.text = widget.studentEdit!.name;
      store.schoolNameController.text = widget.studentEdit!.schoolName;
      store.schoolGradeController.text = widget.studentEdit!.schoolGrade == null
          ? ""
          : widget.studentEdit!.schoolGrade!;
      store.dateBirthdayController.text =
          '${widget.studentEdit!.birthday.day}/${widget.studentEdit!.birthday.month}/${widget.studentEdit!.birthday.year}';
      store.dateCreateController.text =
          '${widget.studentEdit!.dateregistry.day}/${widget.studentEdit!.dateregistry.month}/${widget.studentEdit!.dateregistry.year}';
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
    listenerDates();
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.isCreate != null) {
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
          leading: widget.isCreate == null
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
        body: ValueListenableBuilder(
            valueListenable: store,
            builder: (context, state, _) {
              if (state is StudentCreateLoadingState) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            color: Color.fromARGB(
                                                255, 207, 203, 203),
                                          ),
                                          child: Icon(Icons.person_2_outlined,
                                              size: size.height * 0.08),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormFieldWidget(
                                          hintText: "Nome",
                                          controller:
                                              store.nameStudentController,
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
                                          controller:
                                              store.dateBirthdayController,
                                          keyboardType: TextInputType.datetime,
                                          hintText: 'Data de Nascimento',
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Escola",
                                          controller:
                                              store.schoolNameController,
                                          validator: (String? value) {
                                            return null;
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Ano Escolar",
                                          controller:
                                              store.schoolGradeController,
                                          validator: (String? value) {
                                            return null;
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Nacionalidade",
                                          controller:
                                              store.nationalityController,
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
                                          children: [
                                            RadioListTile(
                                              groupValue:
                                                  store.typeSponsorSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  store.typeSponsorSelected =
                                                      value!;
                                                });
                                              },
                                              title: Text('Pai'),
                                              value: 'Pai',
                                            ),
                                            RadioListTile(
                                              groupValue:
                                                  store.typeSponsorSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  store.typeSponsorSelected =
                                                      value!;
                                                });
                                              },
                                              title: Text('Mãe'),
                                              value: 'Mãe',
                                            ),
                                            RadioListTile(
                                                groupValue:
                                                    store.typeSponsorSelected,
                                                onChanged: (value) {
                                                  setState(() {
                                                    store.typeSponsorSelected =
                                                        value!;
                                                  });
                                                },
                                                title: Text('Avo(ó)'),
                                                value: 'Avo(ó)'),
                                            RadioListTile(
                                                groupValue:
                                                    store.typeSponsorSelected,
                                                onChanged: (value) {
                                                  setState(() {
                                                    store.typeSponsorSelected =
                                                        value!;
                                                  });
                                                },
                                                title: Text('Irmão(a)'),
                                                value: 'Irmão(a)'),
                                            RadioListTile(
                                                groupValue:
                                                    store.typeSponsorSelected,
                                                onChanged: (value) {
                                                  setState(() {
                                                    store.typeSponsorSelected =
                                                        value!;
                                                  });
                                                },
                                                title: Text('Outro'),
                                                value: 'Outro'),
                                          ],
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Nome do Responsável",
                                          controller:
                                              store.responsibleController,
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
                                          keyboardType: TextInputType.number,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "CPF é obrigatório";
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Telefone (DDD)",
                                          controller: store.telephoneController,
                                          keyboardType: TextInputType.number,
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
                                          controller: store.addressController,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Rua é obrigatório";
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Número",
                                          keyboardType: TextInputType.number,
                                          controller:
                                              store.addressNumberController,
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
                                          controller:
                                              store.addressCityController,
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
                                          controller:
                                              store.dateCreateController,
                                          keyboardType: TextInputType.datetime,
                                          hintText: 'Data do Registro',
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                                value:
                                                    store.useOfImageController,
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
                                          children: getCrews(),
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
                                  if (store.selectedCrews.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Obrigatório vincular em uma turma!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  if (store.typeSponsorSelected.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Obrigatório definir o tipo de responsável!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  if (_formKey.currentState!.validate() &&
                                      store.typeSponsorSelected.isNotEmpty &&
                                      store.selectedCrews.isNotEmpty) {
                                    var student = Student(
                                        crews: [],
                                        id: store.isEdit
                                            ? widget.studentEdit!.id
                                            : null,
                                        relationship: store.typeSponsorSelected,
                                        active: store.activeController,
                                        address: store.addressController.text,
                                        allergy: store.allergyController.text,
                                        birthday: store.dateBirthday,
                                        addressCity:
                                            store.addressCityController.text,
                                        addressDistrict: store
                                            .addressDistrictController.text,
                                        addressNumber:
                                            store.addressNumberController.text,
                                        dateregistry: store.dateCreate,
                                        responsible:
                                            store.responsibleController.text,
                                        name: store.nameStudentController.text,
                                        schoolName: store.schoolNameController
                                                .text.isEmpty
                                            ? ''
                                            : store.schoolNameController.text,
                                        telephone:
                                            store.telephoneController.text,
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

                                    if (widget.isCreate != null) {
                                      Navigator.of(context)
                                          .pushNamed(createStudentSuccess);
                                    }

                                    if (state is StudentCreateSuccessState &&
                                        widget.isCreate == null) {
                                      Navigator.of(context)
                                          .pop(widget.isCreate);
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

  listenerDates() {
    store.dateBirthdayController.addListener(() {
      final text = store.dateBirthdayController.text;

      if (text.length == 2 || text.length == 5) {
        store.dateBirthdayController.text = text + '/';
        store.dateBirthdayController.selection =
            TextSelection.collapsed(offset: text.length + 1);
      }
      if (text.length == 10) {
        final DateFormat format = DateFormat('dd/MM/yyyy');
        try {
          final DateTime dateTime = format.parse(text);
          // Faça algo com a dateTime, como atribuir ao store.dateBirthday
          store.dateBirthday = dateTime;
          debugPrint(store.dateBirthday.toString());
        } catch (e) {
          print('Erro ao analisar a data: $e');
        }
      }
    });
    store.dateCreateController.addListener(() {
      final text = store.dateCreateController.text;

      if (text.length == 2 || text.length == 5) {
        store.dateCreateController.text = text + '/';
        store.dateCreateController.selection =
            TextSelection.collapsed(offset: text.length + 1);
      }
      if (text.length == 10) {
        final DateFormat format = DateFormat('dd/MM/yyyy');
        try {
          final DateTime dateTime = format.parse(text);
          // Faça algo com a dateTime, como atribuir ao store.dateBirthday
          store.dateCreate = dateTime;
          debugPrint(store.dateCreate.toString());
        } catch (e) {
          print('Erro ao analisar a data: $e');
        }
      }
    });
  }

  List<Widget> getCrews() {
    List<Widget> itensCrews = [];
    store.crews.forEach((element) {
      itensCrews.add(CheckboxListTile(
        title: Text("${element.name}  -  ${element.key}"),
        value: store.selectedCrews.contains(element.id),
        onChanged: (value) {
          setState(() {
            if (value!) {
              store.selectedCrews.add(element.id!);
            } else {
              store.selectedCrews.remove(element.id!);
            }
          });
        },
      ));
    });

    return itensCrews;
  }
}
