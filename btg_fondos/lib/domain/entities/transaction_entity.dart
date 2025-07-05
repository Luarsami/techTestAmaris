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

  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      id: json['id'],
      type: json['type'],
      fundName: json['fundName'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'fundName': fundName,
      'amount': amount,
      'date': date,
    };
  }
}
