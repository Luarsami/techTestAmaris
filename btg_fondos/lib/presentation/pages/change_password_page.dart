// 📁 lib/presentation/pages/change_password_page.dart
import 'package:flutter/material.dart';
import '../../services/password_service.dart';
import '../widgets/password_form.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final PasswordService _passwordService = PasswordService();

  void _onUpdatePassword() async {
    final current = currentPass.text.trim();
    final newPassword = newPass.text.trim();
    final result = await _passwordService.changePassword(current, newPassword);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result.message)));

    if (result.success) {
      currentPass.clear();
      newPass.clear();
    }
  }

  @override
  void dispose() {
    currentPass.dispose();
    newPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cambio de contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PasswordForm(
          currentController: currentPass,
          newController: newPass,
          onSubmit: _onUpdatePassword,
        ),
      ),
    );
  }
}
