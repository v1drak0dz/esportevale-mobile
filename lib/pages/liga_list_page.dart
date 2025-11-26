import 'package:flutter/material.dart';
import '../models/liga.dart';
import '../services/api_service.dart';
import 'tabela_page.dart';
import 'jogos_list_page.dart';

class LigaListPage extends StatelessWidget {
  const LigaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Liga>>(
      future: ApiService.fetchLigas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erro: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Nenhuma liga encontrada"));
        }

        final ligas = snapshot.data!;
        return ListView.builder(
          itemCount: ligas.length,
          itemBuilder: (context, index) {
            final liga = ligas[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      liga.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    JogosPage(ligaId: int.parse(liga.id)),
                              ),
                            );
                          },
                          icon: const Icon(Icons.sports_soccer),
                          label: const Text("Partidas"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TabelaPage(ligaId: int.parse(liga.id)),
                              ),
                            );
                          },
                          icon: const Icon(Icons.leaderboard),
                          label: const Text("Classificação"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
