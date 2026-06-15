import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_theme.dart';
import 'package:simple_mortgage/features/home/home_page.dart';

class SimpleMortgageApp extends StatelessWidget {
  const SimpleMortgageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Mortgage LLC | Fairfax Mortgage Broker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
