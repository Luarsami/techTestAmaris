import 'package:equatable/equatable.dart';

abstract class FundEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFundsEvent extends FundEvent {}

class SubscribeToFundEvent extends FundEvent {
  final int fundId;
  final double userBalance;

  SubscribeToFundEvent({required this.fundId, required this.userBalance});

  @override
  List<Object> get props => [fundId, userBalance];
}

class CancelFundEvent extends FundEvent {
  final int fundId;

  CancelFundEvent({required this.fundId});

  @override
  List<Object> get props => [fundId];
}
