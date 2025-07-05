import '../../domain/entities/fund_entity.dart';

class FundModel extends FundEntity {
  FundModel({
    required super.id,
    required super.name,
    required super.minAmount,
    required super.category,
  });

  factory FundModel.fromJson(Map<String, dynamic> json) => FundModel(
    id: json['id'],
    name: json['name'],
    minAmount: (json['minAmount'] as num).toDouble(),
    category: json['category'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'minAmount': minAmount,
    'category': category,
  };
}
