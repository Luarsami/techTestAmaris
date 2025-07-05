import 'package:flutter_test/flutter_test.dart';
import 'package:btg_fondos/domain/entities/fund_entity.dart';
import 'package:btg_fondos/domain/usecases/subscribe_to_fund.dart';
import 'package:btg_fondos/domain/repositories/fund_repository.dart';

class MockFundRepo implements FundRepository {
  @override
  List<FundEntity> getAvailableFunds() {
    return [
      FundEntity(id: 1, name: 'Fondo Test', minAmount: 100000, category: 'FPV'),
    ];
  }
}

void main() {
  group('Reglas de negocio - suscripción', () {
    final usecase = SubscribeToFund(MockFundRepo());

    test('Permite suscripción si el usuario tiene saldo suficiente', () {
      final fund = FundEntity(
        id: 1,
        name: 'FPV_BTG_PACTUAL_RECAUDADORA',
        minAmount: 75000,
        category: 'FPV',
      );

      final result = usecase(fund, 500000);
      expect(result, true);
    });

    test('No permite suscripción si el saldo es menor al mínimo del fondo', () {
      final fund = FundEntity(
        id: 1,
        name: 'FPV_BTG_PACTUAL_RECAUDADORA',
        minAmount: 75000,
        category: 'FPV',
      );

      final result = usecase(fund, 70000);
      expect(result, false);
    });
  });
}
