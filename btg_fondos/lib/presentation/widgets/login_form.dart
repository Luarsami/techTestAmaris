import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;
  final bool isButtonEnabled;
  final VoidCallback onLoginPressed;

  const LoginForm({
    super.key,
    required this.userController,
    required this.passController,
    required this.isButtonEnabled,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: userController,
          decoration: const InputDecoration(labelText: 'Usuario'),
        ),
        TextField(
          controller: passController,
          decoration: const InputDecoration(labelText: 'Contraseña'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isButtonEnabled ? onLoginPressed : null,
          child: const Text('Iniciar sesión'),
        ),
      ],
    );
  }
}
