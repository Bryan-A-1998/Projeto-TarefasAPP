import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/BD/dados.dart';
import 'package:tarefas_app/telas/cadastro.dart';
import 'package:tarefas_app/telas/home.dart';
import 'package:tarefas_app/telas/login.dart';
import 'package:tarefas_app/telas/inicio.dart';
import 'package:tarefas_app/telas/perfil.dart';
import 'package:tarefas_app/telas/tarefas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Dados()),
      ],
      child: MaterialApp(
      title: 'Tarefas App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData
      (
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/inicio': (context) => HomePageteste(),
        '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
        '/perfil': (context) => Perfil(),
        '/tarefas': (context) => Tarefas(),
      },
    ),);
  }
}