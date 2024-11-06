import 'package:flutter/material.dart';
import 'package:tarefas_app/telas/novaTarefa.dart';
import 'package:tarefas_app/telas/perfil.dart';
import 'package:tarefas_app/telas/tarefas.dart';

class HomePageteste extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 leading: Icon(Icons.home),
// title: Text('Tarefas'),
 actions: [
 IconButton(
 icon: Icon(Icons.checklist),
 onPressed: () => Navigator.push(context, MaterialPageRoute(
      builder: (_) => Tarefas(),)),
 ),
 IconButton(
 icon: Icon(Icons.person),
 onPressed: () =>  Navigator.push(context, MaterialPageRoute(
      builder: (_) => Perfil(),)),
 ),
 IconButton(
 icon: Icon(Icons.add),
 onPressed: () => Navigator.push(context, MaterialPageRoute(
      builder: (_) => NovaTarefa(),)),
 ),
 IconButton(
 icon: Icon(Icons.logout),
 onPressed: () =>  Navigator.pop(context),
 ),
 ],
 ),
 body: Center(child: Text('Nenhuma tarefa agendada',
 style: TextStyle(
 color: Colors.black,
 fontSize: 20,
 fontWeight: FontWeight.w900,
 ),
 )),
 );
 }
}
