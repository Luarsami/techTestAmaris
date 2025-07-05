import '../models/fund_model.dart';

abstract class FundLocalDatasource {
  List<FundModel> getFunds();
}
