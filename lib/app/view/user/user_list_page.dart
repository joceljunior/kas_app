import 'package:flutter/material.dart';
import 'package:kas_app/app/models/user.dart';
import 'package:kas_app/app/view/user/store/user_store.dart';
import 'package:kas_app/app/view/user/states/user_states.dart';
import 'package:kas_app/app/view/user/user_create_page.dart';
import 'package:kas_app/core/widgets/simple_appbar_widget.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserStore store = UserStore();

  @override
  void initState() {
    super.initState();
    store.getUsers();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarWidget(
        title: 'Gerenciar Usuários',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToCreateUser(),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF5F4FC),
        child: ValueListenableBuilder<UserState>(
          valueListenable: store,
          builder: (context, state, child) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserListSuccessState) {
              return _buildUserList(state.users);
            }

            if (state is UserErrorState) {
              return _buildErrorWidget(state.message);
            }

            return const Center(child: Text('Nenhum usuário encontrado'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateUser(),
        backgroundColor: Colors.blue[200],
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildUserList(List<dynamic> users) {
    if (users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Nenhum usuário cadastrado',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index] as User;
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: user.isMaster
              ? const Color.fromARGB(255, 236, 159, 186)
              : Colors.blue[200],
          child: Icon(
            user.isMaster ? Icons.admin_panel_settings : Icons.person,
            color: Colors.black,
          ),
        ),
        title: Text(
          user.name ?? user.username,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usuário: ${user.username}'),
            if (user.email != null) Text('Email: ${user.email}'),
            Text(
              'Tipo: ${user.isMaster ? "Master" : "Professora"}',
              style: TextStyle(
                color: user.isMaster
                    ? const Color.fromARGB(255, 236, 159, 186)
                    : Colors.blue[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleMenuAction(value, user),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Desativar'),
                ],
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Erro ao carregar usuários',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => store.getUsers(),
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateUser() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => const UserCreatePage(),
      ),
    )
        .then((_) {
      // Recarregar lista quando voltar
      store.getUsers();
    });
  }

  void _handleMenuAction(String action, User user) {
    switch (action) {
      case 'edit':
        _editUser(user);
        break;
      case 'delete':
        _deleteUser(user);
        break;
    }
  }

  void _editUser(User user) {
    store.setEditMode(user: user);
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => const UserCreatePage(),
      ),
    )
        .then((_) {
      store.clearForm();
      store.getUsers();
    });
  }

  void _deleteUser(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Desativar Usuário'),
        content: Text(
            'Tem certeza que deseja desativar o usuário "${user.name ?? user.username}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteUserById(user.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Desativar'),
          ),
        ],
      ),
    );
  }
}
