import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String userBalanceKey = 'user_balance';
  static const String transactionsKey = 'transactions';

  static Future<void> saveBalance(double balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(userBalanceKey, balance);
  }

  static Future<double> loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(userBalanceKey) ?? 500000.0;
  }

  static Future<void> saveTransactions(List<Map<String, dynamic>> txs) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(transactionsKey, jsonEncode(txs));
  }

  static Future<List<Map<String, dynamic>>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(transactionsKey);
    if (json == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(json));
  }
}
