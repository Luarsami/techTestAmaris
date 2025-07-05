import 'package:btg_fondos/domain/repositories/fund_repository.dart';

import '../../domain/entities/fund_entity.dart';
import '../../core/utils/local_storage.dart';

class FundRepositoryMock implements FundRepository {
  @override
  List<FundEntity> getAvailableFunds() {
    return [
      FundEntity(
        id: 1,
        name: 'FPV_BTG_PACTUAL_RECAUDADORA',
        minAmount: 75000,
        category: 'FPV',
      ),
      FundEntity(
        id: 2,
        name: 'FPV_BTG_PACTUAL_ECOPETROL',
        minAmount: 125000,
        category: 'FPV',
      ),
      FundEntity(
        id: 3,
        name: 'DEUDAPRIVADA',
        minAmount: 50000,
        category: 'FIC',
      ),
      FundEntity(
        id: 4,
        name: 'FDO-ACCIONES',
        minAmount: 250000,
        category: 'FIC',
      ),
      FundEntity(
        id: 5,
        name: 'FPV_BTG_PACTUAL_DINAMICA',
        minAmount: 100000,
        category: 'FPV',
      ),
    ];
  }

  Future<double> getUserBalance() async {
    return await LocalStorage.loadBalance();
  }

  Future<void> updateUserBalance(double balance) async {
    await LocalStorage.saveBalance(balance);
  }
}
