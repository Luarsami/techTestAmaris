import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_fondos/presentation/blocs/fund_bloc.dart';
import 'package:btg_fondos/presentation/blocs/fund_event.dart';
import 'package:btg_fondos/presentation/blocs/fund_state.dart';
import 'package:btg_fondos/domain/entities/fund_entity.dart';
import 'package:btg_fondos/domain/usecases/subscribe_to_fund.dart';
import 'package:btg_fondos/domain/repositories/fund_repository.dart';

class MockFundRepository implements FundRepository {
  @override
  List<FundEntity> getAvailableFunds() {
    return [
      FundEntity(id: 1, name: 'Fondo A', minAmount: 75000, category: 'FPV'),
      FundEntity(id: 2, name: 'Fondo B', minAmount: 125000, category: 'FIC'),
    ];
  }
}

void main() {
  late FundBloc bloc;

  setUp(() {
    final repository = MockFundRepository();
    final usecase = SubscribeToFund(repository);
    bloc = FundBloc(repository: repository, usecase: usecase);
  });

  group('FundBloc', () {
    blocTest<FundBloc, FundState>(
      'emite [FundLoading, FundLoaded] cuando se dispara LoadFundsEvent',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadFundsEvent()),
      expect: () => [FundLoading(), isA<FundLoaded>()],
    );

    blocTest<FundBloc, FundState>(
      'emite FundSubscriptionSuccess cuando el saldo es suficiente',
      build: () => bloc,
      act:
          (bloc) =>
              bloc.add(SubscribeToFundEvent(fundId: 1, userBalance: 80000)),
      expect:
          () => [
            FundSubscriptionSuccess('Suscripción exitosa al fondo Fondo A'),
          ],
    );

    blocTest<FundBloc, FundState>(
      'emite FundError cuando el saldo es insuficiente',
      build: () => bloc,
      act:
          (bloc) =>
              bloc.add(SubscribeToFundEvent(fundId: 2, userBalance: 100000)),
      expect:
          () => [
            FundError(
              'No tiene saldo disponible para vincularse al fondo Fondo B',
            ),
          ],
    );

    blocTest<FundBloc, FundState>(
      'emite FundSubscriptionSuccess al cancelar un fondo',
      build: () => bloc,
      act: (bloc) => bloc.add(CancelFundEvent(fundId: 1)),
      expect:
          () => [
            FundSubscriptionSuccess(
              'Cancelación exitosa del fondo Fondo A. Se ha devuelto \$75000 al saldo.',
            ),
          ],
    );
  });
}
