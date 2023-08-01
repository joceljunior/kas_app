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
      padding: EdgeInsets.all(size.height * 0.003),
      child: Container(
        padding: EdgeInsets.all(size.height * 0.02),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/dancing_ballet.png'), // Substitua pela localização da sua imagem
              fit: BoxFit.cover,
              opacity: 0.1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0B3C8),
              Colors.pink[50]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  logoSplash,
                  height: size.height * 0.2,
                ),
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content:
                                Text('Tem certeza que deseja efetuar logout?'),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await loginOntroller.logout();
                                      Navigator.of(context).pop();
                                      await Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              initialRoute, ((route) => false));
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
                    color: Color.fromARGB(255, 227, 130, 130),
                    Icons.logout_rounded,
                    size: size.height * 0.04,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Olá",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
