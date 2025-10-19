import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RelatoriosPage extends StatelessWidget {
  const RelatoriosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Relatórios")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Histórico de Temperatura e Umidade",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text("Valores"),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10, // mostra de 10 em 10
                        getTitlesWidget: (value, meta) {
                          return Text("${value.toInt()}");
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text("Dias"),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1, // mostra todo ponto
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text("Seg");
                            case 1:
                              return const Text("Ter");
                            case 2:
                              return const Text("Qua");
                            case 3:
                              return const Text("Qui");
                            case 4:
                              return const Text("Sex");
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    // Temperatura (linha vermelha)
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 22),
                        FlSpot(1, 23),
                        FlSpot(2, 25),
                        FlSpot(3, 24),
                        FlSpot(4, 28),
                      ],
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: Colors.red.withOpacity(0.2)),
                    ),
                    // Umidade (linha azul)
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 50),
                        FlSpot(1, 55),
                        FlSpot(2, 52),
                        FlSpot(3, 60),
                        FlSpot(4, 58),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Legenda simples
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.circle, color: Colors.red, size: 12),
                SizedBox(width: 4),
                Text("Temperatura em C°"),
                SizedBox(width: 20),
                Icon(Icons.circle, color: Colors.blue, size: 12),
                SizedBox(width: 4),
                Text("Umidade em %"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}