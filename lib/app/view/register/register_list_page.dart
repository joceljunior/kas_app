import 'package:flutter/material.dart';
import 'package:kas_app/app/view/register/states/register_states.dart';
import 'package:kas_app/core/constants/routes.dart';

import '../../models/crew.dart';
import 'store/register_list_store.dart';
import 'widgets/register_crew_item_widget.dart';

class RegisterListPage extends StatefulWidget {
  final Crew crew;
  const RegisterListPage({super.key, required this.crew});

  @override
  State<RegisterListPage> createState() => _RegisterListPageState();
}

class _RegisterListPageState extends State<RegisterListPage> {
  final RegisterListStore store = RegisterListStore();
  @override
  void initState() {
    store.register.crewId = widget.crew.id!;
    store.getRegister(idCrew: store.register.crewId);

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
              "Chamadas",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              widget.crew.name,
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),
            Text(
              widget.crew.key,
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ],
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
                    .pushNamed(registerCreatePage, arguments: store.register)
                    .then((value) {
                  store.getRegister(idCrew: widget.crew.id!);
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
          builder: (_, state, child) {
            if (state is RegisterErrorState) {
              return Center(
                child: Text('Ocorreu uma erro'),
              );
            }
            if (state is RegisterLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is RegisterListSuccessState) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.registers.length,
                  itemBuilder: (context, index) {
                    var register = state.registers[index];
                    return RegisterCrewItemWidget(
                      register: register,
                      ontapEdit: () async {
                        await Navigator.of(context)
                            .pushNamed(registerCreatePage, arguments: register)
                            .then((value) {
                          store.getRegister(idCrew: widget.crew.id!);
                        });
                      },
                    );
                  },
                ),
              );
            }
            return Container();
          }),
    );
  }
}
