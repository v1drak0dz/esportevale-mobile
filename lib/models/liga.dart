class Liga {
  final String id;
  final String nome;

  Liga({required this.id, required this.nome});

  factory Liga.fromJson(Map<String, dynamic> json) {
    return Liga(id: json['id'], nome: json['nome'] ?? '');
  }
}
