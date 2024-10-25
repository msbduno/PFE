import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDataColumn(String label, String value, String unit) {
  return Column(
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (unit.isNotEmpty) Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              unit,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}