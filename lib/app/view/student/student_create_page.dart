import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    store.dateCreateController.text =
        '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}';

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
          '${widget.studentEdit!.birthday.day.toString().padLeft(2, '0')}/${widget.studentEdit!.birthday.month.toString().padLeft(2, '0')}/${widget.studentEdit!.birthday.year}';
      store.dateCreateController.text =
          '${widget.studentEdit!.dateregistry.day.toString().padLeft(2, '0')}/${widget.studentEdit!.dateregistry.month.toString().padLeft(2, '0')}/${widget.studentEdit!.dateregistry.year}';
      store.responsibleController.text = widget.studentEdit!.responsible;
      store.activeController = widget.studentEdit!.active;
      store.useOfImageController = widget.studentEdit!.useImage ? 'Sim' : 'Não';
      store.telephoneController.text = widget.studentEdit!.telephone;
    }

    super.initState();
  }

  String toTitleCase(String text) {
    return text.replaceAllMapped(RegExp(r'\b\w'), (match) {
      return match.group(0)!.toUpperCase();
    });
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
    // listenerDates();
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
                                              'Informações do(a) Aluna(o)',
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
                                          hintText:
                                              "Nome Completo do(a) Aluno(a)",
                                          controller:
                                              store.nameStudentController,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Nome do aluno é obrigatório";
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            store.nameStudentController.value =
                                                TextEditingValue(
                                              text: toTitleCase(text),
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Data de Nascimento é obrigatório";
                                            }
                                            // Define o padrão regex para o formato dd/mm/yyyy
                                            final RegExp dateRegex =
                                                RegExp(r'^\d{2}/\d{2}/\d{4}$');
                                            // Verifica se o valor inserido corresponde ao padrão regex
                                            if (!dateRegex.hasMatch(value)) {
                                              return 'Formato inválido. Use dd/mm/yyyy';
                                            }
                                            return null;
                                          },
                                          controller:
                                              store.dateBirthdayController,
                                          keyboardType: TextInputType.datetime,
                                          hintText:
                                              'Data de Nascimento (dd/mm/yyyy)',
                                          onChanged: (text) {},
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Escola",
                                          controller:
                                              store.schoolNameController,
                                          validator: (String? value) {
                                            return null;
                                          },
                                          onChanged: (text) {
                                            store.schoolNameController.value =
                                                TextEditingValue(
                                              text: toTitleCase(
                                                  text), // Converte o texto para o formato desejado
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Ano Escolar",
                                          keyboardType: TextInputType.text,
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
                                          onChanged: (text) {
                                            store.nationalityController.value =
                                                TextEditingValue(
                                              text: toTitleCase(
                                                  text), // Converte o texto para o formato desejado
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
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
                                          hintText:
                                              "Nome Completo do Responsável",
                                          controller:
                                              store.responsibleController,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Nome do responsável é obrigatório";
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            store.responsibleController.value =
                                                TextEditingValue(
                                              text: toTitleCase(
                                                  text), // Converte o texto para o formato desejado
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "CPF (Apenas números)",
                                          controller: store.cpfController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "CPF é obrigatório";
                                            }
                                            if (value.length != 11) {
                                              return "CPF deve conter 11 dígitos";
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Telefone (DDD)",
                                          controller: store.telephoneController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
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
                                          onChanged: (text) {
                                            store.addressController.value =
                                                TextEditingValue(
                                              text: toTitleCase(text),
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
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
                                          hintText: "Complemento",
                                          keyboardType: TextInputType.text,
                                          controller:
                                              store.complementController,
                                          validator: (String? value) {
                                            return null;
                                          },
                                          onChanged: (text) {
                                            store.complementController.value =
                                                TextEditingValue(
                                              text: toTitleCase(text),
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Bairro",
                                          controller:
                                              store.addressDistrictController,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Bairro é obrigatório";
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            store.addressDistrictController
                                                .value = TextEditingValue(
                                              text: toTitleCase(text),
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          hintText: "Cidade",
                                          controller:
                                              store.addressCityController,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Cidade é obrigatório";
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            store.addressCityController.value =
                                                TextEditingValue(
                                              text: toTitleCase(text),
                                              selection: store
                                                  .responsibleController
                                                  .selection,
                                            );
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
                                        SizedBox(height: 8),
                                        TextFormFieldWidget(
                                          hintText:
                                              "Alergia ou Restrição Alimentar?",
                                          controller: store.allergyController,
                                          validator: (String? value) {
                                            return null;
                                          },
                                          onEditingComplete: () {
                                            final text =
                                                store.allergyController.text;
                                            store.allergyController.text =
                                                toTitleCase(text);
                                          },
                                        ),
                                        TextFormFieldWidget(
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Data de Matrícula é obrigatório";
                                            }
                                            // Define o padrão regex para o formato dd/mm/yyyy
                                            final RegExp dateRegex =
                                                RegExp(r'^\d{2}/\d{2}/\d{4}$');
                                            // Verifica se o valor inserido corresponde ao padrão regex
                                            if (!dateRegex.hasMatch(value)) {
                                              return 'Formato inválido. Use dd/mm/yyyy';
                                            }
                                            return null;
                                          },
                                          controller:
                                              store.dateCreateController,
                                          keyboardType: TextInputType.datetime,
                                          hintText: 'Data da Matrícula',
                                        ),
                                        ExpansionTile(
                                          title: Text('Turmas'),
                                          children: getCrews(),
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
                                              'Autorização para uso de imagem',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Você autoriza o uso de imagem do(a) aluno(a) em publicações realizadas exclusivamente nos perfis oficiais da escola (WhatsApp, Facebook, Instagram)?",
                                        ),
                                        RadioListTile(
                                          groupValue:
                                              store.useOfImageController,
                                          onChanged: (value) {
                                            setState(() {
                                              store.useOfImageController =
                                                  value!;
                                            });
                                          },
                                          title: Text('Sim'),
                                          value: 'Sim',
                                        ),
                                        RadioListTile(
                                          groupValue:
                                              store.useOfImageController,
                                          onChanged: (value) {
                                            setState(() {
                                              store.useOfImageController =
                                                  value!;
                                            });
                                          },
                                          title: Text('Não'),
                                          value: 'Não',
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
                                        useImage:
                                            store.useOfImageController == 'Sim'
                                                ? true
                                                : false,
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
