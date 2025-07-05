import 'package:flutter/material.dart';

class UserBalance extends StatelessWidget {
  final double balance;

  const UserBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Saldo actual:', style: TextStyle(fontSize: 16)),
          Text(
            '\$${balance.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
