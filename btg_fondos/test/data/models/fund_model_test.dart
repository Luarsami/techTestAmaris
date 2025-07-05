import 'package:flutter_test/flutter_test.dart';
import 'package:btg_fondos/data/models/fund_model.dart';

void main() {
  test('FundModel fromJson y toJson', () {
    final json = {
      'id': 1,
      'name': 'Fondo Prueba',
      'minAmount': 50000, // int en JSON
      'category': 'FIC',
    };

    final model = FundModel.fromJson(json);

    expect(model.id, 1);
    expect(model.name, 'Fondo Prueba');
    expect(model.minAmount, 50000.0); // validación como double
    expect(model.category, 'FIC');

    final backToJson = model.toJson();

    expect(backToJson['id'], 1);
    expect(backToJson['name'], 'Fondo Prueba');
    expect(backToJson['minAmount'], 50000.0);
    expect(backToJson['category'], 'FIC');
  });
}
