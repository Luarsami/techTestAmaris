import 'package:flutter/material.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionTile({super.key, required this.transaction});

  String _formatDate(String isoDate) {
    final dt = DateTime.tryParse(isoDate);
    return dt != null
        ? '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}'
        : isoDate;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.fundName),
      subtitle: Text('${transaction.type} - ${_formatDate(transaction.date)}'),
      trailing: Text('\$${transaction.amount.toInt()}'),
    );
  }
}
