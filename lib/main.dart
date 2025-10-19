import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ClimaApp());
}

class ClimaApp extends StatefulWidget {
  const ClimaApp({super.key});

  @override
  State<ClimaApp> createState() => _ClimaAppState();
}

class _ClimaAppState extends State<ClimaApp> {
  bool temaEscuro = false;
  double tamanhoFonte = 20;
  double tamanhoIcone = 60;
  IconData iconeTemp = Icons.thermostat;
  IconData iconeUmidade = Icons.water_drop;

  void atualizarConfiguracoes(
      bool novoTema, double novaFonte, double novoIcone, IconData novoTemp, IconData novoUmidade) {
    setState(() {
      temaEscuro = novoTema;
      tamanhoFonte = novaFonte;
      tamanhoIcone = novoIcone;
      iconeTemp = novoTemp;
      iconeUmidade = novoUmidade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima3D',
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        temaEscuro: temaEscuro,
        tamanhoFonte: tamanhoFonte,
        tamanhoIcone: tamanhoIcone,
        iconeTemp: iconeTemp,
        iconeUmidade: iconeUmidade,
        onConfigChange: atualizarConfiguracoes,
      ),
    );
  }
}