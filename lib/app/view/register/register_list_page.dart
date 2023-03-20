import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'store/register_list_store.dart';
import 'widgets/register_crew_item_widget.dart';

class RegisterListPage extends StatefulWidget {
  final int idCrew;
  const RegisterListPage({super.key, required this.idCrew});

  @override
  State<RegisterListPage> createState() => _RegisterListPageState();
}

class _RegisterListPageState extends State<RegisterListPage> {
  final RegisterListStore store = RegisterListStore();
  @override
  void initState() {
    store.getRegister(idCrew: widget.idCrew);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chamadas",
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
                // await Navigator.of(context)
                //     .pushNamed(studentCreatePage)
                //     .then((value) {
                //   store.getStudents();
                // });
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
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
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: store.registers.length,
              itemBuilder: (context, index) {
                var register = store.registers[index];
                return RegisterCrewItemWidget(
                  register: register,
                );
              },
            ),
          );
        }
      }),
    );
  }
}
