import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_login_controller.dart';

import '../constants/assets.dart';
import '../constants/routes.dart';

class AppBarWidget extends StatelessWidget {
  final String userName;
  AppBarWidget({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final ILoginController loginOntroller = GetIt.I<ILoginController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                logoSplash,
                height: size.height * 0.2,
              ),
              FloatingActionButton.small(
                backgroundColor: Colors.blue[400],
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content:
                              Text('Tem certeza que deseja efetuar logout?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await loginOntroller.logout();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            loginPage, ((route) => false));
                                  },
                                  child: Text("Confirma"),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
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
                child: Icon(
                  Icons.logout,
                ),
              )
            ],
          ),
          Text(
            userName.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.2, vertical: size.height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30 Turmas'),
                Text('206 Alunos'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
