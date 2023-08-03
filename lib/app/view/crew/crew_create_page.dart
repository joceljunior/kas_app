import 'package:flutter/material.dart';
import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/view/crew/store/crew_create_store.dart';
import 'package:kas_app/core/widgets/button_widget.dart';
import 'package:kas_app/core/widgets/textformfield_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CrewCreatePage extends StatefulWidget {
  final Crew? crewEdit;
  const CrewCreatePage({super.key, required this.crewEdit});

  @override
  State<CrewCreatePage> createState() => _CrewCreatePageState();
}

class _CrewCreatePageState extends State<CrewCreatePage> {
  final CrewCreateStore store = CrewCreateStore();

  @override
  void initState() {
    if (widget.crewEdit != null) {
      store.nameCrewController.text = widget.crewEdit!.name;
      store.idCrewController.text = widget.crewEdit!.key;
      store.isEdit = true;
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
      body: ModalProgressHUD(
        inAsyncCall: store.loading,
        child: Container(
          color: Colors.white10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormFieldWidget(
                    hintText: "Nome da Turma",
                    controller: store.nameCrewController,
                    validator: (String? value) => value,
                  ),
                  TextFormFieldWidget(
                    hintText: "Identificador",
                    controller: store.idCrewController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) => value,
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
                    var crew = Crew(
                        id: widget.crewEdit != null
                            ? widget.crewEdit!.id
                            : null,
                        name: store.nameCrewController.text,
                        key: store.idCrewController.text);

                    await store.createCrew(isEdit: store.isEdit, crew: crew);

                    if (store.success) {
                      Navigator.of(context).pop();
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
}
