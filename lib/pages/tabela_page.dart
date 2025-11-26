import 'package:flutter/material.dart';
import '../models/tabela.dart';
import '../services/api_service.dart';

class TabelaPage extends StatelessWidget {
  final int ligaId;

  const TabelaPage({super.key, required this.ligaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classificação")),
      body: FutureBuilder<List<Tabela>>(
        future: ApiService.fetchTabela(ligaId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma tabela encontrada"));
          }

          final tabela = snapshot.data!;

          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    Colors.grey.shade200,
                  ),
                  columnSpacing: 24,
                  dataRowHeight: 48,
                  columns: const [
                    DataColumn(label: Text("Pos")),
                    DataColumn(label: Text("Time")),
                    DataColumn(label: Text("J")),
                    DataColumn(label: Text("V")),
                    DataColumn(label: Text("E")),
                    DataColumn(label: Text("D")),
                    DataColumn(label: Text("GP")),
                    DataColumn(label: Text("GC")),
                    DataColumn(label: Text("SG")),
                    DataColumn(label: Text("Pts")),
                  ],
                  rows: List.generate(tabela.length, (index) {
                    final row = tabela[index];

                    // Define cor da linha
                    Color? rowColor;
                    if (index < 5) {
                      rowColor = Colors.green.shade50; // primeiras 5
                    } else if (index >= tabela.length - 5) {
                      rowColor = Colors.red.shade50; // últimas 5
                    }

                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) => rowColor,
                      ),
                      cells: [
                        DataCell(Text("${index + 1}")),
                        DataCell(
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  row.brasao, // ajuste para o nome do campo correto
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  row.time,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text("${row.jogos}")),
                        DataCell(Text("${row.vitorias}")),
                        DataCell(Text("${row.empates}")),
                        DataCell(Text("${row.derrotas}")),
                        DataCell(Text("${row.golsPro}")),
                        DataCell(Text("${row.golsContra}")),
                        DataCell(Text("${row.saldoGols}")),
                        DataCell(
                          Text(
                            "${row.pontos}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
