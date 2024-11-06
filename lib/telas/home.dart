import 'package:flutter/material.dart';
import 'package:tarefas_app/telas/cadastro.dart';
import 'package:tarefas_app/telas/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Método para registrar o usuário
  void _cadastrar() {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => Cadastro(),));
  }

  // Método para login do usuário
  void _login() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => Login(),));
  }

  // Exibir feedback ao usuário
  void _showSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas APP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 200),
            OutlinedButton(
              onPressed: _cadastrar,
              child: Text('Cadastrar-se'),
            ),            
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),            
          ],
        ),
      ),
    );
  }
}
