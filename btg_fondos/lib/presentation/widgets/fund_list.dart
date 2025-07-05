import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/fund_bloc.dart';
import '../blocs/fund_state.dart';
import '../blocs/fund_event.dart';

class FundList extends StatelessWidget {
  final double userBalance;
  final String selectedNotification;
  final VoidCallback onSuccess;

  const FundList({
    super.key,
    required this.userBalance,
    required this.selectedNotification,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FundBloc, FundState>(
      listener: (context, state) {
        if (state is FundSubscriptionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.message} (Notificación por $selectedNotification)',
              ),
              backgroundColor: Colors.green,
            ),
          );
          onSuccess();
        } else if (state is FundError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is FundLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FundLoaded) {
          return ListView.builder(
            itemCount: state.funds.length,
            itemBuilder: (context, index) {
              final fund = state.funds[index];
              return ListTile(
                title: Text(fund.name),
                subtitle: Text(
                  'Mínimo: \$${fund.minAmount.toInt()} - ${fund.category}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<FundBloc>().add(
                          SubscribeToFundEvent(
                            fundId: fund.id,
                            userBalance: userBalance,
                          ),
                        );
                      },
                      child: const Text('Suscribirse'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        context.read<FundBloc>().add(
                          CancelFundEvent(fundId: fund.id),
                        );
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: Text('Esperando datos...'));
      },
    );
  }
}
