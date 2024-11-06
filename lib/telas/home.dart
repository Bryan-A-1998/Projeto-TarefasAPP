import 'package:flutter/material.dart';
import 'package:tarefas_app/telas/cadastro.dart';
import 'package:tarefas_app/telas/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  //final List<Map<String, String>> _usuarios = [];

// Função para verificar o formato do email
  /*bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }*/

  // Método para registrar o usuário
  void _cadastrar() {
    //final email = _emailController.text;
   // final senha = _senhaController.text;

    Navigator.push(context, MaterialPageRoute(
        builder: (_) => Cadastro(),));

    /*if (email.isEmpty || senha.isEmpty) {
      _showSnackBar('Preencha todos os campos!');
    } else if (!_isEmailValid(email)) {
      _showSnackBar('Por favor, insira um email válido.');
    } else  {
      setState(() {
        _usuarios.add({'email': email, 'senha': senha});
      });
      _showSnackBar('Usuário registrado com sucesso!');
      _emailController.clear();
      _senhaController.clear();
    }*/
    

  }

  // Método para login do usuário
  void _login() {
Navigator.push(context, MaterialPageRoute(
        builder: (_) => Login(),));

  /*  final email = _emailController.text;
    final senha = _senhaController.text;

    final usuario = _usuarios.firstWhere(
      (user) => user['email'] == email && user['senha'] == senha,
      orElse: () => {},
    );

    if (usuario.isNotEmpty) {
      _showSnackBar('Login bem-sucedido!');
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => HomePageteste(),));
    } else {
      _showSnackBar('Credenciais inválidas!');
    }*/
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
            SizedBox(height: 100),
            /*TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),*/
            SizedBox(height: 100),
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
