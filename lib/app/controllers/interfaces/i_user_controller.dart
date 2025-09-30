import '../../models/user.dart';

abstract class IUserController {
  Future<List<User>> getUsers({int page = 1, int pageSize = 10});
  Future<List<User>> getTeachers();
  Future<User> getUserById({required String id});
  Future<User> createUser({required User user});
  Future<bool> updateUser({required User user});
  Future<bool> deleteUser({required String id});
  Future<bool> deactivateUser({required String id});
  Future<List<User>> searchUsers({required String query});
}
