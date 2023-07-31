import 'package:flutter/material.dart';

import '../../core/routes/kas_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kas Ballet',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 236, 159, 186),
      ),
      // initialRoute: initialRoute,
      onGenerateRoute: KasRouter().generateRoute,
    );
  }
}
