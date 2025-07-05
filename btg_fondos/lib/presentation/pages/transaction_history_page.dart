import 'package:flutter/material.dart';
import '../../core/utils/local_storage.dart';
import '../../domain/entities/transaction_entity.dart';
import '../widgets/transaction_tile.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  List<TransactionEntity> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final jsonList = await LocalStorage.loadTransactions();
    setState(() {
      transactions =
          jsonList.map((json) => TransactionEntity.fromJson(json)).toList()
            ..sort((a, b) => b.date.compareTo(a.date));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Transacciones')),
      body:
          transactions.isEmpty
              ? const Center(child: Text('No hay transacciones aún'))
              : ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return TransactionTile(transaction: transactions[index]);
                },
              ),
    );
  }
}
