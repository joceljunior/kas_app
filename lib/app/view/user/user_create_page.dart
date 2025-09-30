import 'package:flutter/material.dart';
import 'package:kas_app/app/view/user/store/user_store.dart';
import 'package:kas_app/app/view/user/states/user_states.dart';
import 'package:kas_app/core/widgets/simple_appbar_widget.dart';

class UserCreatePage extends StatefulWidget {
  const UserCreatePage({Key? key}) : super(key: key);

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final UserStore store = UserStore();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: SimpleAppBarWidget(
        title: store.isEdit ? 'Editar Usuário' : 'Cadastrar Usuário',
        showBackButton: true,
      ),
      body: Container(
        color: const Color(0xFFF5F4FC),
        child: ValueListenableBuilder<UserState>(
          valueListenable: store,
          builder: (context, state, child) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNameField(),
                    SizedBox(height: size.height * 0.02),
                    _buildUsernameField(),
                    SizedBox(height: size.height * 0.02),
                    _buildPasswordField(),
                    SizedBox(height: size.height * 0.02),
                    _buildEmailField(),
                    SizedBox(height: size.height * 0.02),
                    _buildPhoneField(),
                    SizedBox(height: size.height * 0.02),
                    _buildRoleField(),
                    SizedBox(height: size.height * 0.04),
                    _buildSaveButton(),
                    SizedBox(height: size.height * 0.02),
                    if (state is UserErrorState)
                      _buildErrorWidget(state.message),
                    if (state is UserSuccessState)
                      _buildSuccessWidget(state.message),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: store.nameController,
      decoration: const InputDecoration(
        labelText: 'Nome Completo *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nome é obrigatório';
        }
        return null;
      },
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: store.usernameController,
      decoration: const InputDecoration(
        labelText: 'Nome de Usuário *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.account_circle),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nome de usuário é obrigatório';
        }
        if (value.length < 3) {
          return 'Nome de usuário deve ter pelo menos 3 caracteres';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: store.passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText:
            store.isEdit ? 'Nova Senha (deixe vazio para manter)' : 'Senha *',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
      ),
      validator: (value) {
        if (!store.isEdit && (value == null || value.isEmpty)) {
          return 'Senha é obrigatória';
        }
        if (value != null && value.isNotEmpty && value.length < 6) {
          return 'Senha deve ter pelo menos 6 caracteres';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: store.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email (opcional)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Email inválido';
          }
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: store.phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Telefone (opcional)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }

  Widget _buildRoleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de Usuário *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: store.selectedRole,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.work),
          ),
          items: const [
            DropdownMenuItem(
              value: 'master',
              child: Text('Master (Administrador)'),
            ),
            DropdownMenuItem(
              value: 'teacher',
              child: Text('Professora'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              store.selectedRole = value!;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tipo de usuário é obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          store.saveUser();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        store.isEdit ? 'Atualizar Usuário' : 'Cadastrar Usuário',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.red.shade600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.green.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
