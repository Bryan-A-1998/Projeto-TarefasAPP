import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/controles/autentificacao.dart';
import 'package:tarefas_app/telas/cadastro.dart';
import 'package:tarefas_app/telas/home.dart';
import 'package:tarefas_app/telas/inicio.dart';

class Login extends StatefulWidget{
  @override
   _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  // Método para login do usuário
  void _login() async{
    final email = _emailController.text;
    final senha = _senhaController.text;

    try {
      await context.read<autentificacao>().login(email, senha);
      () => Navigator.push(context, MaterialPageRoute(
      builder: (_) => HomePageteste(),));
    } on authExeption catch (e) {
      _showSnackBar(e.msg);
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => Home(),));
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
      appBar: AppBar(title: Text('Login')),
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
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => Cadastro(),)),
              child: Text('Registrar-se'),)
          ],
        ),
      ),
    );
  }
}
