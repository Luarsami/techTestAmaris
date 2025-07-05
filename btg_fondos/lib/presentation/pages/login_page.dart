import 'package:flutter/material.dart';
import 'home_page.dart'; // Ajusta si tu ruta es diferente

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final List<Map<String, dynamic>> usersMock = [
    {
      'username': 'admin',
      'password': 'admin123',
      'role': 'admin',
      'balance': 500000,
    },
    {'username': 'consultor1', 'password': 'consultor123', 'role': 'consultor'},
  ];

  void _login() {
    final username = userController.text.trim();
    final password = passController.text.trim();

    final user = usersMock.firstWhere(
      (u) => u['username'] == username && u['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bienvenido ${user['role']}')));

      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(userData: user)),
        );
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Usuario o contraseña inválidos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Iniciar sesión')),
          ],
        ),
      ),
    );
  }
}
