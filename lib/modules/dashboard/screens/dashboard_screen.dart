import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(
            child: AutoSizeText('DASHBOARD'),
          )
        ],
      ),
    );
  }
}
