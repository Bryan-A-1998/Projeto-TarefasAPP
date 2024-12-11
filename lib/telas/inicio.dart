import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/controles/autentificacao.dart';
import 'package:tarefas_app/telas/novaTarefa.dart';
import 'package:tarefas_app/telas/tarefas.dart';

import '../BD/dados.dart';

class HomePageteste extends StatelessWidget {
 @override
 Widget build(BuildContext context) {  
    final dadostarefas = Provider.of<Dados>(context);
 return Scaffold(
 appBar: AppBar(
 leading: IconButton(
 icon: Tooltip(
  message: 'HOME',
  child: Icon(Icons.home),),
 onPressed: () => '',
 ),
 title: Text('Home Tarefas'),
 actions: [
 IconButton(
 icon: Tooltip(
  message: 'Tarefas',
  child: Icon(Icons.checklist),),
 onPressed: () => Navigator.push(context, MaterialPageRoute(
      builder: (_) => Tarefas(),)),
 ),
 IconButton(
 icon: Tooltip(
  message: 'Adicionar Tarefa',
  child: Icon(Icons.add),),
 onPressed: () => Navigator.push(context, MaterialPageRoute(
      builder: (_) => NovaTarefa(),)),
 ),
 IconButton(
 icon: Tooltip(
  message: 'Deslogar',
  child: Icon(Icons.logout),),
 onPressed: () =>  context.read<autentificacao>().Logout(),
 ),
 ],
 ),
 
 body: dadostarefas.tarefas
        .where((tarefa) =>
            tarefa.data.year == DateTime.now().year &&
            tarefa.data.month == DateTime.now().month &&
            tarefa.data.day == DateTime.now().day)
        .isEmpty
    ? Center(
        child: Text(
          'Nenhuma tarefa para hoje!',
          style: TextStyle( 
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w900,),
        ),
      )
    : ListView.builder(
        // Filtra as tarefas do dia atual
        itemCount: dadostarefas.tarefas
            .where((tarefa) =>
                tarefa.data.year == DateTime.now().year &&
                tarefa.data.month == DateTime.now().month &&
                tarefa.data.day == DateTime.now().day)
            .length,
        itemBuilder: (context, index) {
          // Obtém apenas as tarefas do dia atual
          final tarefa = dadostarefas.tarefas
              .where((tarefa) =>
                  tarefa.data.year == DateTime.now().year &&
                  tarefa.data.month == DateTime.now().month &&
                  tarefa.data.day == DateTime.now().day)
              .toList()[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                tarefa.nome,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data: ${tarefa.data.day}/${tarefa.data.month}/${tarefa.data.year} às ${tarefa.data.hour}:${tarefa.data.minute.toString().padLeft(2, '0')}',
                  ),
                  SizedBox(height: 5),
                  Text('Descrição: ${tarefa.descricao}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Confirmação antes da exclusão
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir Tarefa'),
                      content: Text(
                          'Tem certeza que deseja excluir a tarefa "${tarefa.nome}"?'),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text('Excluir', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            // Remove a tarefa do provider
                            dadostarefas.excluirTarefa(tarefa);
                            Navigator.pop(context);
                            },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
 );
 }
}
