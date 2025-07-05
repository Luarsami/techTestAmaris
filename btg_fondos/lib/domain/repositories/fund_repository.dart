import '../entities/fund_entity.dart';

abstract class FundRepository {
  List<FundEntity> getAvailableFunds();
}
