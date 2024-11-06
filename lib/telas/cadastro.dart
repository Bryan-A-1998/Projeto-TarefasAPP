import 'package:flutter/material.dart';
import 'package:tarefas_app/BD/globais.dart';

class Cadastro extends StatefulWidget{
  @override
   _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  // Função para verificar o formato do email
    bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Método para registrar o usuário
  void _cadastrar() {
    final email = _emailController.text;
    final senha = _senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      _showSnackBar('Preencha todos os campos!');
    } else if (!_isEmailValid(email)) {
      _showSnackBar('Por favor, insira um email válido.');
    } else {
      setState(() {
      usuarios.add({'email': email, 'senha': senha});
      });
      _showSnackBar('Usuário registrado com sucesso!');
      _emailController.clear();
      _senhaController.clear();
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
