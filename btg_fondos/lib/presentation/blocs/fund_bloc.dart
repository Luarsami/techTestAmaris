import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/fund_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/fund_repository.dart';
import '../../domain/usecases/subscribe_to_fund.dart';
import '../../core/utils/local_storage.dart';
import 'package:uuid/uuid.dart';
import 'fund_event.dart';
import 'fund_state.dart';

class FundBloc extends Bloc<FundEvent, FundState> {
  final FundRepository repository;
  final SubscribeToFund usecase;
  final uuid = Uuid();

  FundBloc({required this.repository, required this.usecase})
    : super(FundInitial()) {
    on<LoadFundsEvent>((event, emit) async {
      emit(FundLoading());
      try {
        final funds = repository.getAvailableFunds();
        emit(FundLoaded(funds));
      } catch (_) {
        emit(FundError('Error cargando los fondos'));
      }
    });

    on<SubscribeToFundEvent>((event, emit) async {
      try {
        final fund = repository.getAvailableFunds().firstWhere(
          (f) => f.id == event.fundId,
          orElse: () => throw Exception('Fondo no encontrado'),
        );

        final isValid = usecase(fund, event.userBalance);

        if (isValid) {
          final transaction = TransactionEntity(
            id: uuid.v4(),
            type: 'SUSCRIPCIÓN',
            fundName: fund.name,
            amount: fund.minAmount,
            date: DateTime.now().toIso8601String(),
          );

          final current = await LocalStorage.loadTransactions();
          current.add(transaction.toJson());
          await LocalStorage.saveTransactions(current);
          await LocalStorage.saveBalance(event.userBalance - fund.minAmount);

          emit(
            FundSubscriptionSuccess(
              'Suscripción exitosa al fondo ${fund.name}',
            ),
          );
        } else {
          emit(
            FundError(
              'No tiene saldo disponible para vincularse al fondo ${fund.name}',
            ),
          );
        }

        final updatedFunds = repository.getAvailableFunds();
        emit(FundLoaded(updatedFunds));
      } catch (e) {
        emit(FundError('Error al suscribirse: ${e.toString()}'));
        emit(FundLoaded(repository.getAvailableFunds()));
      }
    });

    on<CancelFundEvent>((event, emit) async {
      try {
        final fund = repository.getAvailableFunds().firstWhere(
          (f) => f.id == event.fundId,
        );

        final transaction = TransactionEntity(
          id: uuid.v4(),
          type: 'CANCELACIÓN',
          fundName: fund.name,
          amount: fund.minAmount,
          date: DateTime.now().toIso8601String(),
        );

        final current = await LocalStorage.loadTransactions();
        current.add(transaction.toJson());
        await LocalStorage.saveTransactions(current);
        final oldBalance = await LocalStorage.loadBalance();
        await LocalStorage.saveBalance(oldBalance + fund.minAmount);

        emit(
          FundSubscriptionSuccess(
            'Cancelación exitosa del fondo ${fund.name}. Se ha devuelto \$${fund.minAmount.toInt()} al saldo.',
          ),
        );

        final updatedFunds = repository.getAvailableFunds();
        emit(FundLoaded(updatedFunds));
      } catch (e) {
        emit(FundError('Error al cancelar: ${e.toString()}'));
        emit(FundLoaded(repository.getAvailableFunds()));
      }
    });
  }
}
