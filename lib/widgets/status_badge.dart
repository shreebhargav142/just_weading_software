import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Delivered':
        bgColor = const Color(0xFFE0F7FA); // Light Cyan
        textColor = const Color(0xFF00695C);
        break;
      case 'In Process':
        bgColor = const Color(0xFFFFF3E0); // Light Orange
        textColor = const Color(0xFFEF6C00);
        break;
      case 'Canceled':
        bgColor = const Color(0xFFFFEBEE); // Light Red
        textColor = const Color(0xFFC62828);
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.black87;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 12
        ),
      ),
    );
  }
}