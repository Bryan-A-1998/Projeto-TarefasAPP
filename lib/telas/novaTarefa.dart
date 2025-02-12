import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarefas_app/modelos/tarefa.dart';
import '../BD/dados.dart';
import '../serviços/api.dart';

class NovaTarefa extends StatefulWidget {
  const NovaTarefa({super.key});

  @override
  State<NovaTarefa> createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> with TickerProviderStateMixin {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;
  File? _imagem; 
  late Dados dadotarefa;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Animação para o botão piscar
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.5).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  // Método para capturar imagem com a câmera
  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  // Função que se conecta à API para salvar a tarefa
  Future<void> _adicionarTarefa() async {
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
      titulo: _nomeController.text,
      dataHora: DateTime(
        _dataSelecionada!.year,
        _dataSelecionada!.month,
        _dataSelecionada!.day,
        _horaSelecionada!.hour,
        _horaSelecionada!.minute,
      ),
      descricao: _descricaoController.text,
      foto: _imagem?.path,
    );

    String? txtfoto: tarefa.foto;

    // Chama o método da API para salvar a tarefa no servidor
    bool sucesso = await ApiService.criarTarefa(
      tarefa.titulo,
      tarefa.descricao,
      tarefa.dataHora,
      txtfoto,
    );

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarefa adicionada com sucesso!')),
      );
      Navigator.pop(context); // Fecha a tela de criação de tarefa
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar tarefa!')),
      );
    }
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

            // Exibição da imagem capturada
            _imagem != null
                ? Center(
                    child: Image.file(_imagem!, width: 150, height: 150),
                  )
                : Center(
                    child: Text('Nenhuma imagem capturada'),
                  ),
            SizedBox(height: 16),

            // Botão piscante para capturar imagem
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: ElevatedButton.icon(
                      onPressed: _tirarFoto,
                      icon: Icon(Icons.camera_alt),
                      label: Text('Capturar Imagem'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, 
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _adicionarTarefa, // Chamando a função de adicionar tarefa
                child: Text('Adicionar Tarefa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
