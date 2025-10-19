import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  final bool temaEscuro;
  final double tamanhoFonte;
  final double tamanhoIcone;
  final IconData iconeTemp;
  final IconData iconeUmidade;
  final Function(bool, double, double, IconData, IconData) onConfigChange;

  const ConfiguracoesPage({
    super.key,
    required this.temaEscuro,
    required this.tamanhoFonte,
    required this.tamanhoIcone,
    required this.iconeTemp,
    required this.iconeUmidade,
    required this.onConfigChange,
  });

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late bool temaEscuro;
  late double tamanhoFonte;
  late double tamanhoIcone;
  late IconData iconeTemp;
  late IconData iconeUmidade;

  final List<IconData> opcoesIcones = [
    Icons.thermostat,
    Icons.local_fire_department,
    Icons.sunny,
    Icons.water_drop,
    Icons.cloud,
    Icons.ac_unit,
  ];

  @override
  void initState() {
    super.initState();
    temaEscuro = widget.temaEscuro;
    tamanhoFonte = widget.tamanhoFonte;
    tamanhoIcone = widget.tamanhoIcone;
    iconeTemp = widget.iconeTemp;
    iconeUmidade = widget.iconeUmidade;
  }

  void atualizarConfig() {
    widget.onConfigChange(temaEscuro, tamanhoFonte, tamanhoIcone, iconeTemp, iconeUmidade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Tema
            SwitchListTile(
              title: const Text("Tema escuro"),
              value: temaEscuro,
              onChanged: (valor) {
                setState(() => temaEscuro = valor);
                atualizarConfig();
              },
            ),

            const Divider(),

            // Fonte
            Text("Tamanho da fonte: ${tamanhoFonte.toStringAsFixed(0)}"),
            Slider(
              min: 14,
              max: 40,
              value: tamanhoFonte,
              onChanged: (valor) {
                setState(() => tamanhoFonte = valor);
                atualizarConfig();
              },
            ),

            const Divider(),

            // Ícones
            Text("Tamanho dos ícones: ${tamanhoIcone.toStringAsFixed(0)}"),
            Slider(
              min: 30,
              max: 100,
              value: tamanhoIcone,
              onChanged: (valor) {
                setState(() => tamanhoIcone = valor);
                atualizarConfig();
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text("Ícone Temperatura: "),
                const SizedBox(width: 10),
                DropdownButton<IconData>(
                  value: iconeTemp,
                  items: opcoesIcones.map((icone) {
                    return DropdownMenuItem(
                      value: icone,
                      child: Icon(icone),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() => iconeTemp = valor!);
                    atualizarConfig();
                  },
                ),
              ],
            ),

            Row(
              children: [
                const Text("Ícone Umidade: "),
                const SizedBox(width: 10),
                DropdownButton<IconData>(
                  value: iconeUmidade,
                  items: opcoesIcones.map((icone) {
                    return DropdownMenuItem(
                      value: icone,
                      child: Icon(icone),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() => iconeUmidade = valor!);
                    atualizarConfig();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}