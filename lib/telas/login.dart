import 'package:flutter/material.dart';
import 'inicio.dart';

class Login extends StatefulWidget{
  @override
   _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final List<Map<String, String>> _usuarios = [];

  // Método para login do usuário
  void _login() {
    final email = _emailController.text;
    final senha = _senhaController.text;

    final usuario = _usuarios.firstWhere(
      (user) => user['email'] == email && user['senha'] == senha,
      orElse: () => {},
    );

    if (usuario.isNotEmpty) {
      _showSnackBar('Login bem-sucedido!');
      Navigator.pushNamed(context, '/tela1');
    } else {
      _showSnackBar('Credenciais inválidas!');
        Navigator.push(context, MaterialPageRoute(
        builder: (_) => HomePageteste()));
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
          ],
        ),
      ),
    );
  }
}
