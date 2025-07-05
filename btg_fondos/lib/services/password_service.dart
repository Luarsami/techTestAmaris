import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordChangeResult {
  final bool success;
  final String message;

  PasswordChangeResult({required this.success, required this.message});
}

class PasswordService {
  Future<PasswordChangeResult> changePassword(
    String current,
    String newPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('logged_user');

    if (jsonStr == null) {
      return PasswordChangeResult(
        success: false,
        message: 'Error: Usuario no autenticado',
      );
    }

    final user = jsonDecode(jsonStr);

    if (user['password'] != current) {
      return PasswordChangeResult(
        success: false,
        message: 'Contraseña actual incorrecta',
      );
    }

    if (newPassword.length < 6) {
      return PasswordChangeResult(
        success: false,
        message: 'La nueva contraseña debe tener al menos 6 caracteres',
      );
    }

    if (newPassword == current) {
      return PasswordChangeResult(
        success: false,
        message: 'La nueva contraseña no puede ser igual a la anterior',
      );
    }

    user['password'] = newPassword;
    await prefs.setString('logged_user', jsonEncode(user));

    return PasswordChangeResult(
      success: true,
      message: 'Contraseña actualizada exitosamente',
    );
  }
}
