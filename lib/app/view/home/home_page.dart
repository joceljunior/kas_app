import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:kas_app/core/database/interface/i_database.dart';
import 'package:kas_app/core/database/entity/session.dart';
import 'package:kas_app/core/widgets/appbar_widget.dart';
import 'package:kas_app/core/widgets/background_base_widget.dart';

class HomePage extends StatelessWidget {
  final Session session;
  HomePage({
    Key? key,
    required this.session,
  }) : super(key: key);

  final IDatabase db = GetIt.instance<IDatabase>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgoundBaseWidget(
        size: size.height,
        child: Column(
          children: [
            AppBarWidget(height: size.height * 0.35),
            Container(
              color: Colors.black,
              height: size.height * 0.20,
              width: size.width * 0.20,
            )
          ],
        ),
      ),
    );
  }
}
