import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  static const String routeName = '\VendorsScreen';

  Widget _rowHeader(String title, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.yellow.shade700,
          border: Border.all(color: Colors.grey.shade700),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manage Vendor',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
            ),
          ),
          Row(
            children: [
              _rowHeader('LOGO', 1),
              _rowHeader('BUSINESS NAME', 3),
              _rowHeader('CITY', 2),
              _rowHeader('STATE', 2),
              _rowHeader('ACTION', 1),
              _rowHeader('VIEW MORE', 1),
            ],
          ),
        ],
      ),
    );
  }
}
