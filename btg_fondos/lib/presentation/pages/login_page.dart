import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../widgets/login_form.dart';
import 'navigation_controller_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = AuthService();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    userController.addListener(_updateButtonState);
    passController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          userController.text.trim().isNotEmpty &&
          passController.text.trim().isNotEmpty;
    });
  }

  Future<void> _login() async {
    final username = userController.text.trim();
    final password = passController.text.trim();

    final result = await _authService.login(username, password);

    if (result.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bienvenido ${result.role}')));
      _goToHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña inválidos')),
      );
    }
  }

  void _goToHome() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavigationControllerPage()),
      );
    });
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(
          userController: userController,
          passController: passController,
          isButtonEnabled: isButtonEnabled,
          onLoginPressed: _login,
        ),
      ),
    );
  }
}
