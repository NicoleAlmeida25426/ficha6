import 'package:flutter/material.dart';
import 'baseDados.dart';
import 'register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Registo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Basededados db = Basededados();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Principal')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await db.criatabela();
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tabela criada com sucesso!'))
              );
            },
            child: const Text('Criar Tabela'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistoPage(bd: db)),
              );
            },
            child: const Text('Registar Utilizador'),
          ),
          ElevatedButton(
            onPressed: () {
              db.consulta();
            },
            child: const Text('Consultar Utilizadores'),
          ),
        ],
      ),
    );
  }
}