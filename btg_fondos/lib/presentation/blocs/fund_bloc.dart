import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/fund_entity.dart';
import '../../domain/repositories/fund_repository.dart';
import '../../domain/usecases/subscribe_to_fund.dart';
import 'fund_event.dart';
import 'fund_state.dart';

class FundBloc extends Bloc<FundEvent, FundState> {
  final FundRepository repository;
  final SubscribeToFund usecase;

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

    on<SubscribeToFundEvent>((event, emit) {
      try {
        final fund = repository.getAvailableFunds().firstWhere(
          (f) => f.id == event.fundId,
          orElse: () => throw Exception('Fondo no encontrado'),
        );

        final isValid = usecase(fund, event.userBalance);

        if (isValid) {
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

        // Recargar fondos después de la acción
        final updatedFunds = repository.getAvailableFunds();
        emit(FundLoaded(updatedFunds));
      } catch (e) {
        emit(FundError('Error al suscribirse: ${e.toString()}'));
        emit(FundLoaded(repository.getAvailableFunds())); // fallback
      }
    });

    on<CancelFundEvent>((event, emit) {
      try {
        final fund = repository.getAvailableFunds().firstWhere(
          (f) => f.id == event.fundId,
        );

        emit(
          FundSubscriptionSuccess(
            'Cancelación exitosa del fondo ${fund.name}. Se ha devuelto \$${fund.minAmount.toInt()} al saldo.',
          ),
        );

        final updatedFunds = repository.getAvailableFunds();
        emit(FundLoaded(updatedFunds));
      } catch (e) {
        emit(FundError('Error al cancelar: ${e.toString()}'));
        emit(FundLoaded(repository.getAvailableFunds())); // fallback
      }
    });
  }
}
