import 'package:flutter/material.dart';
import '../pages/bluetooth_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configurações"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/config');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Relatório"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/relatorio');
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
                    onDataReceived: (temp, umid) {
                      // Aqui você pode, por enquanto, só imprimir:
                      print("Temperatura: $temp | Umidade: $umid");
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}