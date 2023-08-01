import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../errors/kas_error.dart';
import 'boxes/storage.dart';
import 'interface/i_database.dart';

class Database implements IDatabase {
  final HiveInterface hive = GetIt.I<HiveInterface>();
  @override
  Future<bool> saveStorage(Storage obj) async {
    try {
      var boxName = obj.boxName();
      var box = hive.box(boxName);
      if (box.isOpen) {
        if (box.isNotEmpty) {
          deleteStorage(boxName);
        }
        box.put(obj.id(), obj);
        return true;
      } else {
        throw BoxClosedFailure(message: 'Ocorreu um erro ao salvar usuario');
      }
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> deleteStorage(String boxName) async {
    try {
      var box = hive.box(boxName);
      if (box.isNotEmpty) {
        for (var key in box.keys) {
          await box.delete(key);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  T? getStorage<T>(String boxName) {
    if (!hive.isBoxOpen(boxName)) {
      throw BoxClosedFailure(message: boxName);
    }
    var box = hive.box(boxName);
    if (box.values.toList().isEmpty) {
      return null;
    }

    return box.values.first;
  }
}
