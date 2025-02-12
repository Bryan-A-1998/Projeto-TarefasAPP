
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarefas_app/controles/autentificacao.dart';
import 'package:tarefas_app/controles/db_fire.dart';
import 'package:tarefas_app/modelos/tarefa.dart';
import 'package:tarefas_app/modelos/usuario.dart';

class Dados extends ChangeNotifier{
  List<Usuario> _userlista = [];
  List<Tarefa> _tarefaslista = [];
  late FirebaseFirestore db;
  late autentificacao auth;

  Dados({required this.auth}){
    _startRepository();
  }

  _startRepository()async {
    await _startFirestore();
    await _readstore();
  }

  _startFirestore(){
    db = Dbfire.get();
  }

  _readstore(){

  }

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

  Future<void> salvarTarefa(String nome, DateTime data, String descricao) async {
  final novaTarefa = Tarefa(titulo: nome, dataHora: data, descricao: descricao);

  // Adiciona à lista local
  _tarefaslista.add(novaTarefa);

  // Salva no Firestore usando um ID único
  await db
      .collection('usuarios/${auth.usuario!.email}/Tarefas')
      .doc(nome) // Usar o nome como ID ou um UUID
      .set({
    'nome': nome,
    'data': data.toIso8601String(), // Salvar a data como string
    'descricao': descricao,
  });

  notifyListeners();
}
/*
  savarTarefa(String nome, DateTime data, String descricao) async {
    _tarefaslista.add(Tarefa(nome: nome, data: data, descricao: descricao));
    await db.collection('usuarios/${auth.usuario!.email}/Tarefas')
    .doc('tarefa')
    .set({
      'nome': nome,
      'data': data,
      'descricao': descricao
    });
    notifyListeners();
  }
  
  excluirTarefa(Tarefa tarefa) {
    _tarefaslista.remove(tarefa);
    notifyListeners();
  }*/

  Future<void> excluirTarefa(Tarefa tarefa) async {
  // Remove da lista local
  _tarefaslista.remove(tarefa);

  // Remove do Firestore
  await db
      .collection('usuarios/${auth.usuario!.email}/Tarefas')
      .doc(tarefa.titulo) // Certifique-se de que o identificador corresponde
      .delete();

  notifyListeners();
}

  /*
  void removerTarefas(List<Tarefa> tarefasARemover) {
  for (var tarefa in tarefasARemover) {
    _tarefaslista.remove(tarefa);
  }
  notifyListeners();
}
*/
Future<void> removerTarefas(List<Tarefa> tarefasARemover) async {
  for (var tarefa in tarefasARemover) {
    _tarefaslista.remove(tarefa);

    // Remove do Firestore
    await db
        .collection('usuarios/${auth.usuario!.email}/Tarefas')
        .doc(tarefa.titulo)
        .delete();
  }
  notifyListeners();
}


Future<void> sincronizarTarefas() async {
  final snapshot = await db
      .collection('usuarios/${auth.usuario!.email}/Tarefas')
      .get();

  // Atualiza a lista local
  _tarefaslista = snapshot.docs.map((doc) {
    final data = doc.data();
    return Tarefa(
      titulo: data['nome'],
      dataHora: DateTime.parse(data['data']),
      descricao: data['descricao'],
    );
  }).toList();

  notifyListeners();
}


}