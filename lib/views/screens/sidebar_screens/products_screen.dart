import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = '\ProductsScreen';

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
              'Manage Products',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
            ),
          ),
          Row(
            children: [
              _rowHeader('IMAGE', 1),
              _rowHeader('PRODUCT NAME', 3),
              _rowHeader('PRICE', 2),
              _rowHeader('QUANTITY', 2),
              _rowHeader('ACTION', 1),
              _rowHeader('VIEW MORE', 1),
            ],
          ),
        ],
      ),
    );
  }
}
