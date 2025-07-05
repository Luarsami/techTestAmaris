import '../entities/fund_entity.dart';
import '../repositories/fund_repository.dart';

class SubscribeToFund {
  final FundRepository repository;

  SubscribeToFund(this.repository);

  bool call(FundEntity fund, double userBalance) {
    return userBalance >= fund.minAmount;
  }
}
