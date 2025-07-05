import 'package:flutter/material.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<TransactionEntity> history;

  TransactionHistoryPage({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial de transacciones')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final tx = history[index];
          return ListTile(
            title: Text('${tx.type}: ${tx.fundName}'),
            subtitle: Text('COP \$${tx.amount.toInt()} - ${tx.date}'),
          );
        },
      ),
    );
  }
}
