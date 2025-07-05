import 'package:equatable/equatable.dart';
import '../../domain/entities/fund_entity.dart';

abstract class FundState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FundInitial extends FundState {}

class FundLoading extends FundState {}

class FundLoaded extends FundState {
  final List<FundEntity> funds;

  FundLoaded(this.funds);

  @override
  List<Object?> get props => [funds];
}

class FundSubscriptionSuccess extends FundState {
  final String message;

  FundSubscriptionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class FundError extends FundState {
  final String message;

  FundError(this.message);

  @override
  List<Object?> get props => [message];
}
