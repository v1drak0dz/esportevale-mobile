import 'dart:convert';
import 'package:esportevale/models/jogos.dart';
import 'package:esportevale/models/liga.dart';
import 'package:esportevale/models/tabela.dart';
import 'package:http/http.dart' as http;
import '../models/video.dart';

class ApiService {
  static Future<List<Video>> fetchVideos() async {
    final url = Uri.parse("https://www.esportevale.com.br/mobile/videos");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar vídeos');
    }
  }

  static Future<List<Liga>> fetchLigas() async {
    final url = Uri.parse("https://www.esportevale.com.br/mobile/ligas");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Liga.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar ligas');
    }
  }

  static Future<List<Tabela>> fetchTabela(int ligaId) async {
    final url = Uri.parse(
      "https://www.esportevale.com.br/mobile/tabela?id=$ligaId",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // pega só a lista dentro de "data"
      final List<dynamic> data = jsonResponse['data'];

      return data.map((json) => Tabela.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar tabela');
    }
  }

  static Future<List<Jogos>> fetchJogos(int ligaId, int rodada) async {
    String base = "https://www.esportevale.com.br/mobile/jogos?id=$ligaId";
    if (rodada != 0) {
      base += "&rodada=$rodada";
    }
    final url = Uri.parse(base);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // pega só a lista dentro de "data"
      final List<dynamic> data = jsonResponse['data'];
      return data.map((json) => Jogos.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar tabela');
    }
  }
}
