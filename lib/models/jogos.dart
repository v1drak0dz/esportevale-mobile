class Jogos {
  final String id;
  final String campeonato;
  final int rodada;
  final String grupo;
  final String data;
  final String timeCasaNome;
  final String timeForaNome;
  final String timeCasaBrasao;
  final String timeForaBrasao;
  final int golsCasa;
  final int golsFora;
  final bool finalizada;

  // Construtor
  Jogos({
    required this.id,
    required this.campeonato,
    required this.rodada,
    required this.grupo,
    required this.data,
    required this.timeCasaNome,
    required this.timeForaNome,
    required this.timeCasaBrasao,
    required this.timeForaBrasao,
    required this.golsCasa,
    required this.golsFora,
    required this.finalizada,
  });

  // Factory para criar a partir de JSON
  factory Jogos.fromJson(Map<String, dynamic> json) {
    return Jogos(
      id: json['id'].toString(),
      grupo: json['grupo'],
      rodada: json['rodada'],
      campeonato: json['campeonato_nome'] ?? '',
      data: json['data_partida'] ?? '',
      timeCasaNome: json['casa_nome'] ?? '',
      timeForaNome: json['fora_nome'] ?? '',
      timeCasaBrasao: json['casa_brasao'] ?? '',
      timeForaBrasao: json['fora_brasao'] ?? '',
      golsCasa: int.tryParse(json['gols_casa'].toString()) ?? 0,
      golsFora: int.tryParse(json['gols_fora'].toString()) ?? 0,
      finalizada:
          json['finalizada'].toString() == '1' || json['finalizada'] == true,
    );
  }

  // Método para converter de volta em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grupo': grupo,
      'rodada': rodada,
      'campeonato_nome': campeonato,
      'data_partida': data,
      'casa_nome': timeCasaNome,
      'casa_brasao': timeCasaBrasao,
      'fora_nome': timeForaNome,
      'fora_brasao': timeForaBrasao,
      'gols_casa': golsCasa,
      'gols_fora': golsFora,
      'finalizada': finalizada,
    };
  }
}
