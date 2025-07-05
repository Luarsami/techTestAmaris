import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btg_fondos/presentation/blocs/fund_bloc.dart';
import 'package:btg_fondos/presentation/pages/navigation_controller_page.dart';
import 'package:btg_fondos/data/repositories/fund_repository_mock.dart';
import 'package:btg_fondos/domain/usecases/subscribe_to_fund.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => FundBloc(
                repository: FundRepositoryMock(),
                usecase: SubscribeToFund(FundRepositoryMock()),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTG Fondos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NavigationControllerPage(),
    );
  }
}
