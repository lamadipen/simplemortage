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
                'Change any number and see the impact immediately. Your full '
                'estimated payment stays visible with a clear cost breakdown.',
          ),
          SizedBox(height: 44),
          MortgageCalculator(),
        ],
      ),
    );
  }
}
