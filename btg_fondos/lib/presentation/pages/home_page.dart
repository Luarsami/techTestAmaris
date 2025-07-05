// 📁 lib/presentation/pages/home_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/local_storage.dart';
import '../blocs/fund_bloc.dart';
import '../blocs/fund_event.dart';
import '../blocs/fund_state.dart';
import '../widgets/user_balance.dart';
import '../widgets/fund_list.dart';
import 'change_password_page.dart';
import 'transaction_history_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double userBalance = 0;
  String userRole = 'desconocido';
  String selectedNotification = 'email';

  @override
  void initState() {
    super.initState();
    _loadUserAndBalance();
    context.read<FundBloc>().add(LoadFundsEvent());
  }

  Future<void> _loadUserAndBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('logged_user');
    final balance = await LocalStorage.loadBalance();

    if (jsonStr != null) {
      final user = Map<String, dynamic>.from(await jsonDecode(jsonStr));
      setState(() {
        userRole = user['role'] ?? 'desconocido';
        userBalance = balance;
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_user');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));

    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fondos (${userRole.toUpperCase()})'),
        actions: [
          if (userRole == 'admin' || userRole == 'consultor')
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'Historial',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TransactionHistoryPage()),
                );
              },
            ),
          if (userRole == 'admin' || userRole == 'consultor')
            IconButton(
              icon: const Icon(Icons.lock),
              tooltip: 'Cambiar contraseña',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChangePasswordPage()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body:
          userRole == 'consultor'
              ? const Center(
                child: Text('Solo puedes ver el historial de transacciones.'),
              )
              : Column(
                children: [
                  UserBalance(balance: userBalance),
                  _buildNotificationSelector(),
                  Expanded(
                    child: FundList(
                      userBalance: userBalance,
                      selectedNotification: selectedNotification,
                      onSuccess: _loadUserAndBalance,
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildNotificationSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Row(
        children: [
          const Text('Notificación: '),
          const SizedBox(width: 12),
          DropdownButton<String>(
            value: selectedNotification,
            items:
                ['email', 'sms']
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toUpperCase()),
                      ),
                    )
                    .toList(),
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
    );
  }
}
