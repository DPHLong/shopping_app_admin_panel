import 'package:flutter/material.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName = '\WithdrawalScreen';

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
              'Manage Withdrawal',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
            ),
          ),
          Row(
            children: [
              _rowHeader('NAME', 1),
              _rowHeader('AMOUNT', 3),
              _rowHeader('BANK NAME', 2),
              _rowHeader('BANK ACCOUNT', 2),
              _rowHeader('EMAIL', 1),
              _rowHeader('PHONE', 1),
            ],
          ),
        ],
      ),
    );
  }
}
