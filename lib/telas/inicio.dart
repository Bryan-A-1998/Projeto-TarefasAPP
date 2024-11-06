import 'package:flutter/material.dart';

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
 onPressed: () => print('Ver todas as tarefas'),
 ),
 IconButton(
 icon: Icon(Icons.person),
 onPressed: () => print('Visualizar Perfil'),
 ),
 IconButton(
 icon: Icon(Icons.add),
 onPressed: () => print('Adicionar tarefa'),
 ),
 IconButton(
 icon: Icon(Icons.logout),
 onPressed: () => print('Logout'),
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
