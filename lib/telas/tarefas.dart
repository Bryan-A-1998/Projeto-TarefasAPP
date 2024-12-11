import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/BD/dados.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  State<Tarefas> createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  // Set para armazenar as tarefas selecionadas para exclusão
  Set<int> tarefasSelecionadas = Set();

  @override
  Widget build(BuildContext context) {
    final dadostarefas = Provider.of<Dados>(context);

    // Função para remover as tarefas selecionadas
    void excluirTarefasSelecionadas() {
      // Confirmação antes da exclusão
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir Tarefas'),
                      content: Text(
                          'Tem certeza que deseja excluir as tarefas?'),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text('Excluir', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                              // Filtra as tarefas que estão no Set tarefasSelecionadas e as remove
                            dadostarefas.removerTarefas(
                              dadostarefas.tarefas.where((tarefa) {
                                return tarefasSelecionadas.contains(dadostarefas.tarefas.indexOf(tarefa));
                              }).toList());
                              
                              // Limpa as seleções após a exclusão
                            setState(() {
                              tarefasSelecionadas.clear();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
     /* // Filtra as tarefas que estão no Set tarefasSelecionadas e as remove
      dadostarefas.removerTarefas(
          dadostarefas.tarefas.where((tarefa) {
        return tarefasSelecionadas.contains(dadostarefas.tarefas.indexOf(tarefa));
      }).toList()); */
      

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Todas as Tarefas'),
        actions: [
          // Botão para excluir as tarefas selecionadas
          if (tarefasSelecionadas.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: excluirTarefasSelecionadas,
            ),
        ],
      ),
      body: dadostarefas.tarefas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa cadastrada!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: dadostarefas.tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = dadostarefas.tarefas[index];
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
                    trailing: Icon(
                      Icons.task_alt,
                      color: tarefasSelecionadas.contains(index)
                          ? Colors.red
                          : Colors.green,
                    ),
                    leading: Checkbox(
                      value: tarefasSelecionadas.contains(index),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            tarefasSelecionadas.add(index);
                          } else {
                            tarefasSelecionadas.remove(index);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}