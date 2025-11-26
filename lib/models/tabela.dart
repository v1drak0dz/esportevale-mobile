class Tabela {
  final int timeId;
  final String brasao;
  final String time;
  final int campeonatoId;
  final String campeonato;
  final String grupo;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsPro;
  final int golsContra;
  final int saldoGols;
  final int pontos;

  // Construtor
  Tabela({
    required this.timeId,
    required this.brasao,
    required this.time,
    required this.campeonatoId,
    required this.campeonato,
    required this.grupo,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsPro,
    required this.golsContra,
    required this.saldoGols,
    required this.pontos,
  });

  // Factory para criar a partir de JSON
  factory Tabela.fromJson(Map<String, dynamic> json) {
    return Tabela(
      timeId: int.tryParse(json['time_id'].toString()) ?? 0,
      brasao: json['brasao'] ?? '',
      time: json['time'] ?? '',
      campeonatoId: int.tryParse(json['campeonato_id'].toString()) ?? 0,
      campeonato: json['campeonato'] ?? '',
      grupo: json['grupo'] ?? '',
      jogos: int.tryParse(json['jogos'].toString()) ?? 0,
      vitorias: int.tryParse(json['vitorias'].toString()) ?? 0,
      empates: int.tryParse(json['empates'].toString()) ?? 0,
      derrotas: int.tryParse(json['derrotas'].toString()) ?? 0,
      golsPro: int.tryParse(json['gols_pro'].toString()) ?? 0,
      golsContra: int.tryParse(json['gols_contra'].toString()) ?? 0,
      saldoGols: int.tryParse(json['saldo_gols'].toString()) ?? 0,
      pontos: int.tryParse(json['pontos'].toString()) ?? 0,
    );
  }

  // Método para converter de volta em JSON
  Map<String, dynamic> toJson() {
    return {
      'time_id': timeId,
      'brasao': brasao,
      'time': time,
      'campeonato_id': campeonatoId,
      'campeonato': campeonato,
      'grupo': grupo,
      'jogos': jogos,
      'vitorias': vitorias,
      'empates': empates,
      'derrotas': derrotas,
      'gols_pro': golsPro,
      'gols_contra': golsContra,
      'saldo_gols': saldoGols,
      'pontos': pontos,
    };
  }
}
