
import 'package:flutter/material.dart';
import 'package:tarefas_app/modelos/tarefa.dart';
import 'package:tarefas_app/modelos/usuario.dart';

class Dados extends ChangeNotifier{
  List<Usuario> _userlista = [];
  List<Tarefa> _tarefaslista = [];

  savarUsuario(String email, String senha) {
    _userlista.add(Usuario(email: email, senha: senha));
    notifyListeners();
  }
  
  excluirUsuario(Usuario usuario) {
    _userlista.remove(usuario);
    notifyListeners();
  }

  List<Usuario> get usuario => _userlista;
  List<Tarefa> get tarefas => _tarefaslista;
  
  bool verificarLogin(String email, String senha) {
    return _userlista.any((usuario) =>
        usuario.email == email && usuario.senha == senha);
  }

  savarTarefa(String nome, DateTime data, String descricao) {
    _tarefaslista.add(Tarefa(nome: nome, data: data, descricao: descricao));
    notifyListeners();
  }
  
  excluirTarefa(Tarefa tarefa) {
    _tarefaslista.remove(tarefa);
    notifyListeners();
  }
  
  void removerTarefas(List<Tarefa> tarefasARemover) {
  for (var tarefa in tarefasARemover) {
    _tarefaslista.remove(tarefa);
  }
  notifyListeners();
}

}