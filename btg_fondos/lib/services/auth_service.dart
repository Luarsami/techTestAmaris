import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthResult {
  final bool success;
  final String? role;

  AuthResult({required this.success, this.role});
}

class AuthService {
  final List<Map<String, dynamic>> _usersMock = [
    {
      'username': 'admin',
      'password': 'admin123',
      'role': 'admin',
      'balance': 500000,
    },
    {'username': 'consultor1', 'password': 'consultor123', 'role': 'consultor'},
  ];

  Future<AuthResult> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedStr = prefs.getString('logged_user');

    // Valida contra usuario persistente
    if (storedStr != null) {
      final storedUser = jsonDecode(storedStr);
      if (storedUser['username'] == username &&
          storedUser['password'] == password) {
        return AuthResult(success: true, role: storedUser['role']);
      }
    }

    // Primer login con mock
    final matched = _usersMock.where(
      (u) => u['username'] == username && u['password'] == password,
    );

    if (matched.isNotEmpty) {
      final user = matched.first;
      await prefs.setString('logged_user', jsonEncode(user));
      return AuthResult(success: true, role: user['role']);
    }

    return AuthResult(success: false);
  }
}
