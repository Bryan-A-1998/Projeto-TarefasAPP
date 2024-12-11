import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/BD/dados.dart';
import 'package:tarefas_app/controles/autentificacao.dart';
import 'package:tarefas_app/controles/authcheck.dart';
import 'package:tarefas_app/telas/cadastro.dart';
import 'package:tarefas_app/telas/login.dart';
import 'package:tarefas_app/telas/inicio.dart';
import 'package:tarefas_app/telas/tarefas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => autentificacao()),
        ChangeNotifierProvider(create: (context) => Dados()),
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
        '/': (context) => Authcheck(),
        '/inicio': (context) => HomePageteste(),
        '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
        '/tarefas': (context) => Tarefas(),
      },
    ),);
  }
}