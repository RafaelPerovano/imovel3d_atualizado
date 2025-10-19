import 'package:flutter/material.dart';
import 'dart:math';
import 'configuracoes_page.dart';
import 'relatorios_page.dart';
import 'bluetooth_page.dart';

class HomePage extends StatefulWidget {
  final bool temaEscuro;
  final double tamanhoFonte;
  final double tamanhoIcone;
  final IconData iconeTemp;
  final IconData iconeUmidade;
  final Function(bool, double, double, IconData, IconData) onConfigChange;

  const HomePage({
    super.key,
    required this.temaEscuro,
    required this.tamanhoFonte,
    required this.tamanhoIcone,
    required this.iconeTemp,
    required this.iconeUmidade,
    required this.onConfigChange,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double temperatura = 0;
  double umidade = 0;

  void atualizarValores() {
    setState(() {
      temperatura = 20 + Random().nextDouble() * 10;
      umidade = 40 + Random().nextDouble() * 30;
    });
  }

  @override
  void initState() {
    super.initState();
    atualizarValores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clima3D"), centerTitle: true, backgroundColor: Colors.blue),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Clima3D Menu", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Início"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Relatórios"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RelatoriosPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configurações"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConfiguracoesPage(
                      temaEscuro: widget.temaEscuro,
                      tamanhoFonte: widget.tamanhoFonte,
                      tamanhoIcone: widget.tamanhoIcone,
                      iconeTemp: widget.iconeTemp,
                      iconeUmidade: widget.iconeUmidade,
                      onConfigChange: widget.onConfigChange,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bluetooth),
              title: const Text("Bluetooth"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BluetoothPage(
                      onDataReceived: (novaTemp, novaUmidade) {
                        setState(() {
                          temperatura = novaTemp;
                          umidade = novaUmidade;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.iconeTemp, size: widget.tamanhoIcone, color: Colors.red),
            Text(
              "${temperatura.toStringAsFixed(1)} °C",
              style: TextStyle(fontSize: widget.tamanhoFonte, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Icon(widget.iconeUmidade, size: widget.tamanhoIcone, color: Colors.blue),
            Text(
              "${umidade.toStringAsFixed(1)} %",
              style: TextStyle(fontSize: widget.tamanhoFonte, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}