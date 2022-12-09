import '../entity/session.dart';

abstract class IDatabase {
  Future<bool> create(Session session);
  Future<Session> read();
  Future<bool> update();
  Future<bool> delete();
}
