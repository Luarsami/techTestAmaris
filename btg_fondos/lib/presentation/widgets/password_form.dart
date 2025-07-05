import 'package:flutter/material.dart';

class PasswordForm extends StatelessWidget {
  final TextEditingController currentController;
  final TextEditingController newController;
  final VoidCallback onSubmit;

  const PasswordForm({
    super.key,
    required this.currentController,
    required this.newController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: currentController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Contraseña actual'),
        ),
        TextField(
          controller: newController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Nueva contraseña'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSubmit,
          child: const Text('Actualizar contraseña'),
        ),
      ],
    );
  }
}
