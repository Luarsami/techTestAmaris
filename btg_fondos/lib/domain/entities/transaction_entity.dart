class TransactionEntity {
  final String id;
  final String type;
  final String fundName;
  final double amount;
  final String date;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.fundName,
    required this.amount,
    required this.date,
  });
}
