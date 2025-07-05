import 'package:flutter_test/flutter_test.dart';
import 'package:btg_fondos/core/utils/validators.dart';

void main() {
  test('Valida si el monto es mayor a 0', () {
    expect(isValidAmount(100), true);
    expect(isValidAmount(0), false);
    expect(isValidAmount(-5), false);
  });
}
