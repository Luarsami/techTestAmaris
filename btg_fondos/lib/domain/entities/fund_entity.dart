class FundEntity {
  final int id;
  final String name;
  final double minAmount;
  final String category;

  FundEntity({
    required this.id,
    required this.name,
    required this.minAmount,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'minAmount': minAmount,
    'category': category,
  };

  static FundEntity fromJson(Map<String, dynamic> json) => FundEntity(
    id: json['id'],
    name: json['name'],
    minAmount: json['minAmount'].toDouble(),
    category: json['category'],
  );
}
