import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;

  const InfoItem({
    super.key,
    required this.icono,
    required this.valor,
    required this.etiqueta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icono, size: 28, color: const Color(0xFFE65100)),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          etiqueta,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
