import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kas_app/app/view/crew/store/crew_list_store.dart';
import 'package:kas_app/app/view/crew/widgets/crew_item_widget.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/utils/params_enum.dart';

class CrewListPage extends StatefulWidget {
  final ParamsEnum typePage;
  const CrewListPage({super.key, required this.typePage});

  @override
  State<CrewListPage> createState() => _CrewListPageState();
}

class _CrewListPageState extends State<CrewListPage> {
  final CrewListStore store = CrewListStore();
  @override
  void initState() {
    store.getCrews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 185, 207),
        elevation: 5,
        toolbarHeight: size.height * 0.2,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
        actions: [
          Visibility(
            visible: widget.typePage == ParamsEnum.crew,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: Colors.blue[200],
                onPressed: () async {
                  await Navigator.of(context)
                      .pushNamed(crewCreatePage)
                      .then((value) {
                    store.getCrews();
                  });
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        title: Text(
          "Turmas",
          style: TextStyle(color: Colors.black),
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
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: store.crews.length,
              itemBuilder: (context, index) {
                var crew = store.crews[index];
                return CrewItemWidget(
                  crew: crew,
                  onTapItem: () async {
                    if (widget.typePage == ParamsEnum.crew) {
                      await Navigator.of(context)
                          .pushNamed(crewCreatePage, arguments: crew)
                          .then((value) {
                        store.getCrews();
                      });
                    }
                    if (widget.typePage == ParamsEnum.register) {
                      await Navigator.of(context)
                          .pushNamed(
                        registerListPage,
                        arguments: crew.id,
                      )
                          .then((value) {
                        store.getCrews();
                      });
                    }
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
