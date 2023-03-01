import '../boxes/storage.dart';

abstract class IDatabase {
  T? getStorage<T>(String boxName);
  Future<void> deleteStorage(String boxName);
  Future<bool> saveStorage(Storage obj);
}
