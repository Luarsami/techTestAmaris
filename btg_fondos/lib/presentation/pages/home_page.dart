import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/subscribe_to_fund.dart';
import '../../data/repositories/fund_repository_mock.dart';
import '../blocs/fund_bloc.dart';
import '../blocs/fund_event.dart';
import '../blocs/fund_state.dart';
import 'transaction_history_page.dart';
import 'change_password_page.dart';
import 'login_page.dart';
import '../../domain/entities/transaction_entity.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const HomePage({required this.userData, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double userBalance;
  String selectedNotification = 'email';

  final List<TransactionEntity> mockHistory = [
    TransactionEntity(
      id: 'TX001',
      type: 'SUSCRIPCIÓN',
      fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
      amount: 75000,
      date: '2025-07-05',
    ),
    TransactionEntity(
      id: 'TX002',
      type: 'CANCELACIÓN',
      fundName: 'FIC_BTG_FONDO_GENERAL',
      amount: 50000,
      date: '2025-07-03',
    ),
  ];

  @override
  void initState() {
    super.initState();
    userBalance = (widget.userData['balance'] ?? 0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final String role = widget.userData['role'] ?? 'desconocido';

    return BlocProvider(
      create:
          (_) => FundBloc(
            repository: FundRepositoryMock(),
            usecase: SubscribeToFund(FundRepositoryMock()),
          )..add(LoadFundsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fondos (${role.toUpperCase()})'),
          actions: [
            IconButton(
              icon: Icon(Icons.history),
              tooltip: 'Historial',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TransactionHistoryPage(history: mockHistory),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.lock),
              tooltip: 'Cambiar contraseña',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChangePasswordPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Cerrar sesión',
              onPressed: () => _logout(context),
            ),
          ],
        ),
        body:
            role == 'consultor'
                ? Center(
                  child: Text('Solo puedes ver el historial de transacciones.'),
                )
                : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text('Notificación: '),
                          SizedBox(width: 12),
                          DropdownButton<String>(
                            value: selectedNotification,
                            items:
                                ['email', 'sms'].map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e.toUpperCase()),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedNotification = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<FundBloc, FundState>(
                        listener: (context, state) {
                          if (state is FundSubscriptionSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${state.message} (Notificación por $selectedNotification)',
                                ),
                              ),
                            );
                          } else if (state is FundError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is FundLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is FundLoaded) {
                            return ListView.builder(
                              itemCount: state.funds.length,
                              itemBuilder: (context, index) {
                                final fund = state.funds[index];
                                return ListTile(
                                  title: Text(fund.name),
                                  subtitle: Text(
                                    'Mínimo: \$${fund.minAmount.toInt()}',
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
                                        child: Text('Suscribirse'),
                                      ),
                                      SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () {
                                          context.read<FundBloc>().add(
                                            CancelFundEvent(fundId: fund.id),
                                          );
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Center(child: Text('Esperando acción...'));
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  void _logout(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sesión cerrada')));

    Future.delayed(Duration(milliseconds: 400), () {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
        (route) => false,
      );
    });
  }
}
