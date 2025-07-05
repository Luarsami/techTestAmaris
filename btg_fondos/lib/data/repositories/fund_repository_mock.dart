import '../../domain/entities/fund_entity.dart';
import '../../domain/repositories/fund_repository.dart';

class FundRepositoryMock implements FundRepository {
  @override
  List<FundEntity> getAvailableFunds() {
    return [
      FundEntity(id: 1, name: 'Fondo A', minAmount: 75000, category: 'FPV'),
      FundEntity(id: 2, name: 'Fondo B', minAmount: 125000, category: 'FPV'),
      FundEntity(id: 3, name: 'Fondo C', minAmount: 50000, category: 'FIC'),
    ];
  }
}
