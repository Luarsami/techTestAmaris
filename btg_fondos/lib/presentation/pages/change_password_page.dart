import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController currentPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cambio de contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: currentPass,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña actual'),
            ),
            TextField(
              controller: newPass,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Nueva contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulación
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contraseña actualizada exitosamente'),
                  ),
                );
              },
              child: Text('Actualizar contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
