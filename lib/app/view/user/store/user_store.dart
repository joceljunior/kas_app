import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/app/controllers/interfaces/i_user_controller.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/app/view/user/states/user_states.dart';

class UserStore extends ValueNotifier<UserState> {
  UserStore() : super(UserInitialState());
  final IUserController controller = GetIt.instance<IUserController>();

  // Controllers para o formulário
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedRole = 'teacher'; // 'master' ou 'teacher'
  bool isEdit = false;
  String? editingUserId;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void setEditMode({required User user}) {
    isEdit = true;
    editingUserId = user.id;
    nameController.text = user.name ?? '';
    usernameController.text = user.username;
    emailController.text = user.email ?? '';
    phoneController.text = user.phone ?? '';
    selectedRole = user.role ?? 'teacher';
  }

  void clearForm() {
    isEdit = false;
    editingUserId = null;
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    phoneController.clear();
    selectedRole = 'teacher';
  }

  Future<void> createUser() async {
    try {
      value = UserLoadingState();

      final user = User(
        name: nameController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text,
        role: selectedRole,
        email: emailController.text.trim().isEmpty
            ? null
            : emailController.text.trim(),
        phone: phoneController.text.trim().isEmpty
            ? null
            : phoneController.text.trim(),
        active: true,
        createdAt: DateTime.now(),
      );

      await controller.createUser(user: user);
      value = UserSuccessState(message: 'Usuário criado com sucesso!');
      clearForm();
    } catch (e) {
      value = UserErrorState(message: e.toString());
    }
  }

  Future<void> updateUser() async {
    try {
      value = UserLoadingState();

      final user = User(
        id: editingUserId,
        name: nameController.text.trim(),
        username: usernameController.text.trim(),
        password:
            passwordController.text.isEmpty ? '' : passwordController.text,
        role: selectedRole,
        email: emailController.text.trim().isEmpty
            ? null
            : emailController.text.trim(),
        phone: phoneController.text.trim().isEmpty
            ? null
            : phoneController.text.trim(),
        active: true,
        updatedAt: DateTime.now(),
      );

      await controller.updateUser(user: user);
      value = UserSuccessState(message: 'Usuário atualizado com sucesso!');
      clearForm();
    } catch (e) {
      value = UserErrorState(message: e.toString());
    }
  }

  Future<void> saveUser() async {
    if (isEdit) {
      await updateUser();
    } else {
      await createUser();
    }
  }

  Future<void> getUsers() async {
    try {
      value = UserLoadingState();
      final users = await controller.getUsers();
      value = UserListSuccessState(users: users);
    } catch (e) {
      value = UserErrorState(message: e.toString());
    }
  }

  Future<void> getTeachers() async {
    try {
      value = UserLoadingState();
      final teachers = await controller.getTeachers();
      value = UserListSuccessState(users: teachers);
    } catch (e) {
      value = UserErrorState(message: e.toString());
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      value = UserLoadingState();
      await controller.deactivateUser(id: userId);
      value = UserSuccessState(message: 'Usuário desativado com sucesso!');
      await getUsers(); // Recarregar lista
    } catch (e) {
      value = UserErrorState(message: e.toString());
    }
  }

  Future<void> deleteUserById(String? userId) async {
    if (userId != null) {
      await deleteUser(userId);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
