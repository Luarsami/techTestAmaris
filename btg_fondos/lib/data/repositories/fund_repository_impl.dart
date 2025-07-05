import '../../domain/entities/fund_entity.dart';
import '../../domain/repositories/fund_repository.dart';

class FundRepositoryImpl implements FundRepository {
  @override
  List<FundEntity> getAvailableFunds() {
    // Aquí se integrarían los datos mockeados
    return [];
  }
}
