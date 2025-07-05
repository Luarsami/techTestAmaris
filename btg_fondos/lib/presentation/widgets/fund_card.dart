import 'package:flutter/material.dart';

class FundCard extends StatelessWidget {
  final String title;
  final String subtitle;

  FundCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(title), subtitle: Text(subtitle)));
  }
}
