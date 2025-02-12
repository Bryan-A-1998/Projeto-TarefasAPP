class Tarefa {
  final int? id;
  final String titulo;
  final String descricao;
  final DateTime dataHora;
  final String? foto; // Opcional

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataHora,
    this.foto,
  });

  // Converte JSON para Objeto Tarefa
  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      dataHora: DateTime.parse(json['horario']), 
      foto: json['foto'] ?? null, 
    );
  }

  // Converte Objeto Tarefa para JSON (usado ao enviar requisições)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'horario': dataHora.toIso8601String(),
      'foto': foto,
    };
  }
}
