import 'dart:convert';

import 'package:kas_app/core/database/entity/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interface/i_database.dart';

class Database implements IDatabase {
  @override
  Future<bool> create(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('session', json.encode(session));
    return true;
  }

  @override
  Future<bool> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Session> read() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(
        prefs.getString('session') == null ? '' : prefs.getString('session')!);
  }

  @override
  Future<bool> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
