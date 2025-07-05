import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'home_page.dart';

class NavigationControllerPage extends StatelessWidget {
  const NavigationControllerPage({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('logged_user');
    if (jsonStr == null) return null;
    return jsonDecode(jsonStr);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getUser(),
      builder: (context, snapshot) {
        // 🔒 Muestra spinner solo mientras está cargando
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) return LoginPage();

        switch (user['role']) {
          case 'admin':
          case 'consultor':
            return HomePage();
          default:
            return LoginPage();
        }
      },
    );
  }
}
