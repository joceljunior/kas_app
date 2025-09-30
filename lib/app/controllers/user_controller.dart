import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_user_controller.dart';
import 'package:kas_app/app/repositories/interfaces/i_user_repository.dart';
import 'package:kas_app/app/models/user.dart';

class UserController implements IUserController {
  final IUserRepository repository = GetIt.I<IUserRepository>();

  @override
  Future<List<User>> getUsers({int page = 1, int pageSize = 10}) async {
    try {
      var result = await repository.getUsers(page: page, pageSize: pageSize);
      return result;
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }

  @override
  Future<List<User>> getTeachers() async {
    try {
      var result = await repository.getTeachers();
      return result;
    } catch (e) {
      throw Exception('Erro ao buscar professoras: $e');
    }
  }

  @override
  Future<User> getUserById({required String id}) async {
    try {
      var result = await repository.getUserById(id: id);
      return result;
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }

  @override
  Future<User> createUser({required User user}) async {
    try {
      // Validações básicas
      if (user.username.isEmpty) {
        throw Exception('Nome de usuário é obrigatório');
      }
      if (user.password.isEmpty) {
        throw Exception('Senha é obrigatória');
      }
      if (user.role == null || user.role!.isEmpty) {
        throw Exception('Role é obrigatório');
      }
      if (user.name == null || user.name!.isEmpty) {
        throw Exception('Nome é obrigatório');
      }

      var result = await repository.createUser(user: user);
      return result;
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  @override
  Future<bool> updateUser({required User user}) async {
    try {
      if (user.id == null || user.id!.isEmpty) {
        throw Exception('ID do usuário é obrigatório');
      }

      var result = await repository.updateUser(user: user);
      return result;
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  @override
  Future<bool> deleteUser({required String id}) async {
    try {
      var result = await repository.deleteUser(id: id);
      return result;
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }

  @override
  Future<bool> deactivateUser({required String id}) async {
    try {
      var result = await repository.deactivateUser(id: id);
      return result;
    } catch (e) {
      throw Exception('Erro ao desativar usuário: $e');
    }
  }

  @override
  Future<List<User>> searchUsers({required String query}) async {
    try {
      var result = await repository.searchUsers(query: query);
      return result;
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }
}
