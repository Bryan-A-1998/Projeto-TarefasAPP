import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../modelos/tarefa.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/tarefas';

  // Buscar todas as tarefas
  static Future<List<Tarefa>> fetchTarefas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((tarefa) => Tarefa.fromJson(tarefa)).toList();
      } else {
        throw Exception('Erro ao buscar tarefas');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Criar nova tarefa com ou sem imagem
  static Future<bool> criarTarefa(String titulo, String descricao, DateTime dataHora, File? foto) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(baseUrl));

      // Adiciona os campos de texto
      request.fields['titulo'] = titulo;
      request.fields['descricao'] = descricao;
      request.fields['data_hora'] = dataHora.toIso8601String();

      // Adiciona a imagem se houver
      if (foto != null) {
        request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Erro ao criar tarefa: $e');
    }
  }
}
