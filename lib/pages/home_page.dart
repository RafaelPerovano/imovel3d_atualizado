import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'configuracoes_page.dart';
import 'relatorios_page.dart';
import 'dart:io';

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

  late MqttServerClient client;

  @override
  void initState() {
    super.initState();
    _connectMQTT();
  }

  Future<void> _connectMQTT() async {
    final brokerIP = "192.168.76.104";//InternetAddress.loopbackIPv4.address; // 127.0.0.1

    if (kIsWeb) {
      // Web -> WebSockets
      client = MqttServerClient.withPort(brokerIP, 'flutter_web_client', 9001);
      client.useWebSocket = true;
    } else {
      // Windows / Desktop -> TCP direto
      client = MqttServerClient(brokerIP, 'flutter_client');
    }

    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onConnected = () => print('Conectado ao broker MQTT');
    client.onDisconnected = () => print('Desconectado do broker MQTT');

    try {
      await client.connect();
    } catch (e) {
      print('Erro ao conectar: $e');
      client.disconnect();
      return;
    }

    // Inscrever nos tópicos de temperatura e umidade
    client.subscribe('sensor/temperatura', MqttQos.atMostOnce);
    client.subscribe('sensor/umidade', MqttQos.atMostOnce);

    // Receber mensagens
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        if (c[0].topic == 'sensor/temperatura') {
          temperatura = double.tryParse(message) ?? temperatura;
        } else if (c[0].topic == 'sensor/umidade') {
          umidade = double.tryParse(message) ?? umidade;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clima3D"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Clima3D Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
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
                    MaterialPageRoute(
                        builder: (_) => const RelatoriosPage()));
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
              style: TextStyle(
                  fontSize: widget.tamanhoFonte, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Icon(widget.iconeUmidade, size: widget.tamanhoIcone, color: Colors.blue),
            Text(
              "${umidade.toStringAsFixed(1)} %",
              style: TextStyle(
                  fontSize: widget.tamanhoFonte, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}