import 'package:hive/hive.dart';
import 'package:kas_app/core/database/boxes/storage.dart';
part 'session.g.dart';

@HiveType(typeId: 1)
class Session extends Storage {
  @HiveField(0)
  String? idUSer;
  @HiveField(1)
  String? nameUSer;
  @HiveField(2)
  String? roleUser;
  @HiveField(3)
  String? passwordUser;

  Session({
    this.idUSer,
    this.nameUSer,
    this.roleUser,
    this.passwordUser,
  });

  @override
  String boxName() {
    return "session";
  }

  @override
  String? id() {
    return idUSer;
  }
}
