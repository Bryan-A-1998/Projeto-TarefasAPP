import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/BD/dados.dart';
import 'package:tarefas_app/telas/login.dart';

import '../controles/autentificacao.dart';

class Cadastro extends StatefulWidget{
  @override
   _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  late Dados dadoscadastro;

  // Função para verificar o formato do email
    bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Método para registrar o usuário
  Future<void> _cadastrar() async {
    final email = _emailController.text;
    final senha = _senhaController.text;
    
        try {
      await context.read<autentificacao>().registrar(email, senha);
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => Login(),));
    } on authExeption catch (e) {
      _showSnackBar(e.msg);
    }
  }

  // Exibir feedback ao usuário
  void _showSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    dadoscadastro = Provider.of<Dados>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrar,
              child: Text('Cadastrar-se'),
            ),
          ],
        ),
      ),
    );
  }
  }
