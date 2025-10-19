import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SensorCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}