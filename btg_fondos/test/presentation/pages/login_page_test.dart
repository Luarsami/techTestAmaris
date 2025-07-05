import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_fondos/presentation/pages/login_page.dart';

void main() {
  testWidgets('Login Page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    expect(find.text('Usuario'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
