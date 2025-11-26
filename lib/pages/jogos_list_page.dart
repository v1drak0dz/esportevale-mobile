import 'package:flutter/material.dart';
import '../models/jogos.dart';
import '../services/api_service.dart';

class JogosPage extends StatefulWidget {
  final int ligaId;

  const JogosPage({super.key, required this.ligaId});

  @override
  State<JogosPage> createState() => _JogosPageState();
}

class _JogosPageState extends State<JogosPage> {
  int? selectedRodada;
  late Future<List<Jogos>> futureJogos;

  @override
  void initState() {
    super.initState();
    // inicia sem filtro (ou rodada 1)
    futureJogos = ApiService.fetchJogos(widget.ligaId, 0);
  }

  void _filtrarPorRodada(int rodada) {
    setState(() {
      selectedRodada = rodada;
      futureJogos = ApiService.fetchJogos(widget.ligaId, rodada);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jogos")),
      body: Column(
        children: [
          // Combobox de rodadas
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
              value: selectedRodada,
              hint: const Text("Selecione a rodada"),
              items:
                  List.generate(38, (index) => index + 1) // exemplo: 38 rodadas
                      .map(
                        (rodada) => DropdownMenuItem<int>(
                          value: rodada,
                          child: Text("Rodada $rodada"),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  _filtrarPorRodada(value);
                }
              },
            ),
          ),

          // Lista de jogos
          Expanded(
            child: FutureBuilder<List<Jogos>>(
              future: futureJogos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Nenhum jogo encontrado"));
                }

                final jogos = snapshot.data!;
                return ListView.builder(
                  itemCount: jogos.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    final jogo = jogos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rodada " + jogo.rodada.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  jogo.data,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      jogo.timeCasaBrasao,
                                      width: 50,
                                      height: 50,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(jogo.timeCasaNome),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${jogo.golsCasa} x ${jogo.golsFora}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      jogo.finalizada
                                          ? "Finalizado"
                                          : "Em andamento",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: jogo.finalizada
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                      jogo.timeForaBrasao,
                                      width: 50,
                                      height: 50,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(jogo.timeForaNome),
                                  ],
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
            ),
          ),
        ],
      ),
    );
  }
}
