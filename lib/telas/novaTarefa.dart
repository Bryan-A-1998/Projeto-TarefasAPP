import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/modelos/tarefa.dart';

import '../BD/dados.dart';

class NovaTarefa extends StatefulWidget {
  const NovaTarefa({super.key});

  @override
  State<NovaTarefa> createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;
  late Dados dadotarefa;

  void _selecionarData() async {
    DateTime? data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      setState(() {
        _dataSelecionada = data;
      });
    }
  }

  void _selecionarHora() async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) {
      setState(() {
        _horaSelecionada = hora;
      });
    }
  }

  void _adicionarTarefa() {
    if (_nomeController.text.isEmpty ||
        _dataSelecionada == null ||
        _horaSelecionada == null ||
        _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

  final tarefa = Tarefa(
    nome: _nomeController.text,
    data: DateTime(
      _dataSelecionada!.year,
      _dataSelecionada!.month,
      _dataSelecionada!.day,
      _horaSelecionada!.hour,
      _horaSelecionada!.minute,
    ),
    descricao: _descricaoController.text,
  );

    dadotarefa.savarTarefa(tarefa.nome, tarefa.data, tarefa.descricao);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tarefa adicionada com sucesso!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    dadotarefa = Provider.of<Dados>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Tarefa'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dataSelecionada == null
                        ? 'Nenhuma data selecionada'
                        : 'Data: ${_dataSelecionada!.day}/${_dataSelecionada!.month}/${_dataSelecionada!.year}',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _selecionarData,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _horaSelecionada == null
                        ? 'Nenhum horário selecionado'
                        : 'Hora: ${_horaSelecionada!.hour}:${_horaSelecionada!.minute.toString().padLeft(2, '0')}',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _selecionarHora,
                ),
              ],
            ),
            TextField(
              controller: _descricaoController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Descrição da Tarefa'),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _adicionarTarefa,
                child: Text('Adicionar Tarefa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
