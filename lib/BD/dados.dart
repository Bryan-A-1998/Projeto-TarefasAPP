
import 'package:flutter/material.dart';
import 'package:tarefas_app/modelos/tarefa.dart';
import 'package:tarefas_app/modelos/usuario.dart';

class Dados extends ChangeNotifier{
  List<Usuario> _userlista = [];
  List<Tarefa> _tarefaslista = [];

  savarUsuario(String email, String senha) {
    _userlista.add({'email': email, 'senha': senha} as Usuario);
    notifyListeners();
  }
  
  excluirUsuario(Usuario usuario) {
    _userlista.remove(usuario);
    notifyListeners();
  }

  savarTarefa(String nome, String descricao) {
    _tarefaslista.add({'nome': nome, 'descricao': descricao} as Tarefa);
    notifyListeners();
  }
  
  excluirTarefa(Tarefa tarefa) {
    _tarefaslista.remove(tarefa);
    notifyListeners();
  }
}