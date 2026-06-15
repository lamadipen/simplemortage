import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/calculator/mortgage_calculator.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class MortgageCalculatorSection extends StatelessWidget {
  const MortgageCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      backgroundColor: AppColors.canvas,
      child: Column(
        children: [
          SectionHeading(
            eyebrow: 'Plan with confidence',
            title: 'Estimate your monthly payment',
            description:
                'Explore how your price, down payment, rate, and other costs '
                'come together in one clear monthly estimate.',
          ),
          SizedBox(height: 44),
          MortgageCalculator(),
        ],
      ),
    );
  }
}
