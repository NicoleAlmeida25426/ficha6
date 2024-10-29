import 'package:flutter/material.dart';
import 'baseDados.dart';

class RegistoPage extends StatefulWidget {
  const RegistoPage({super.key, required Basededados bd});

  @override
  // ignore: library_private_types_in_public_api
  _RegistoPageState createState() => _RegistoPageState();
}

class _RegistoPageState extends State<RegistoPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final Basededados db = Basededados();

  void _registarUtilizador() async {
    final login = _loginController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    final telefone = _telefoneController.text;

    // Verifica se o número de telefone contém apenas dígitos
    if (!RegExp(r'^[0-9]+$').hasMatch(telefone)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('O número de telefone deve conter apenas números.')));
      return;
    }

    await db.inserirvalor(login, password, email, telefone);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Utilizador criado com sucesso!')));

    // Limpa os campos
    _loginController.clear();
    _passwordController.clear();
    _emailController.clear();
    _telefoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registar Utilizador')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registarUtilizador,
              child: const Text('Registar'),
            ),
          ],
        ),
      ),
    );
  }
}
