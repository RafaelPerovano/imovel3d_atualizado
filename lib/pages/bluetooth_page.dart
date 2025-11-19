/*import 'package:flutter/material.dart';

class BluetoothPage extends StatefulWidget {
  final Function(double, double) onDataReceived;

  const BluetoothPage({super.key, required this.onDataReceived});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothConnection? connection;
  bool conectado = false;
  String status = "Desconectado";

  void conectar() async {
    try {
      // Substitua pelo nome ou endereço do seu módulo (ex: 98:D3:31:F5:4C:12)
      connection = await BluetoothConnection.toAddress('00:00:00:00:00:00');
      setState(() {
        conectado = true;
        status = "Conectado ao Arduino";
      });

      connection!.input!.listen((data) {
        String recebido = String.fromCharCodes(data).trim();
        if (recebido.contains(",")) {
          List<String> partes = recebido.split(',');
          double temp = double.tryParse(partes[0]) ?? 0;
          double umid = double.tryParse(partes[1]) ?? 0;
          widget.onDataReceived(temp, umid);
        }
      }).onDone(() {
        setState(() {
          conectado = false;
          status = "Conexão encerrada";
        });
      });
    } catch (e) {
      setState(() => status = "Erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: conectar,
              child: Text(conectado ? "Conectado" : "Conectar"),
            ),
          ],
        ),
      ),
    );
  }
}*/