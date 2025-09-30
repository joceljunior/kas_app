import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/repositories/interfaces/i_user_repository.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserRepository implements IUserRepository {
  final Dio httpService = GetIt.instance<Dio>();

  @override
  Future<List<User>> getUsers({int page = 1, int pageSize = 10}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('_User'))
            ..orderByDescending('createdAt')
            ..setAmountToSkip((page - 1) * pageSize)
            ..setLimit(pageSize);

      final ParseResponse response = await parseQuery.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => User.fromParseObject(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }

  @override
  Future<List<User>> getTeachers() async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('_User'))
            ..whereEqualTo('Role', 'teacher')
            ..whereEqualTo('active', true)
            ..orderByAscending('name');

      final ParseResponse response = await parseQuery.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => User.fromParseObject(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar professoras: $e');
    }
  }

  @override
  Future<User> getUserById({required String id}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('_User'))
            ..whereEqualTo('objectId', id);

      final ParseResponse response = await parseQuery.query();

      if (response.success &&
          response.results != null &&
          response.results!.isNotEmpty) {
        return User.fromParseObject(response.results!.first);
      } else {
        throw Exception('Usuário não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }

  @override
  Future<User> createUser({required User user}) async {
    try {
      // Criar usuário no Parse
      final ParseUser parseUser =
          ParseUser(user.username, user.password, user.email);

      // Definir campos adicionais
      parseUser.set('name', user.name);
      parseUser.set('phone', user.phone);
      parseUser.set('Role', user.role);
      parseUser.set('active', user.active ?? true);

      final ParseResponse response = await parseUser.signUp();

      if (response.success) {
        // Retornar o usuário criado
        return User.fromParseObject(parseUser);
      } else {
        throw Exception('Erro ao criar usuário: ${response.error}');
      }
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  @override
  Future<bool> updateUser({required User user}) async {
    try {
      final ParseUser parseUser = ParseUser.forQuery();
      parseUser.objectId = user.id;

      // Atualizar campos
      if (user.name != null) parseUser.set('name', user.name);
      if (user.email != null) parseUser.set('email', user.email);
      if (user.phone != null) parseUser.set('phone', user.phone);
      if (user.role != null) parseUser.set('Role', user.role);
      if (user.active != null) parseUser.set('active', user.active);

      final ParseResponse response = await parseUser.save();

      return response.success;
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  @override
  Future<bool> deleteUser({required String id}) async {
    try {
      final ParseUser parseUser = ParseUser.forQuery();
      parseUser.objectId = id;

      final ParseResponse response = await parseUser.delete();

      return response.success;
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }

  @override
  Future<bool> deactivateUser({required String id}) async {
    try {
      final ParseUser parseUser = ParseUser.forQuery();
      parseUser.objectId = id;
      parseUser.set('active', false);

      final ParseResponse response = await parseUser.save();

      return response.success;
    } catch (e) {
      throw Exception('Erro ao desativar usuário: $e');
    }
  }

  @override
  Future<List<User>> searchUsers({required String query}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('_User'))
            ..whereContains('name', query)
            ..whereEqualTo('active', true)
            ..orderByAscending('name');

      final ParseResponse response = await parseQuery.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => User.fromParseObject(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }
}
