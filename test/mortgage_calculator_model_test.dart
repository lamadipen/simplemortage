import 'package:flutter_test/flutter_test.dart';
import 'package:simple_mortgage/features/calculator/mortgage_calculator_model.dart';

void main() {
  group('MortgageCalculatorModel', () {
    test('calculates a standard amortized payment and monthly costs', () {
      final result = MortgageCalculatorModel.calculate(
        homePrice: 450000,
        downPayment: 90000,
        annualInterestRate: 6.5,
        termYears: 30,
        annualPropertyTax: 5400,
        annualHomeInsurance: 1800,
        monthlyPmi: 0,
        monthlyHoa: 100,
      );

      expect(result.loanAmount, 360000);
      expect(result.principalAndInterest, closeTo(2275.44, 0.02));
      expect(result.monthlyTaxes, 450);
      expect(result.monthlyInsurance, 150);
      expect(result.totalMonthlyPayment, closeTo(2975.44, 0.02));
    });

    test('supports a zero-interest loan', () {
      final result = MortgageCalculatorModel.calculate(
        homePrice: 240000,
        downPayment: 0,
        annualInterestRate: 0,
        termYears: 20,
        annualPropertyTax: 0,
        annualHomeInsurance: 0,
        monthlyPmi: 0,
        monthlyHoa: 0,
      );

      expect(result.principalAndInterest, 1000);
      expect(result.totalMonthlyPayment, 1000);
    });

    test('does not produce a negative loan amount', () {
      final result = MortgageCalculatorModel.calculate(
        homePrice: 200000,
        downPayment: 250000,
        annualInterestRate: 6,
        termYears: 30,
        annualPropertyTax: 0,
        annualHomeInsurance: 0,
        monthlyPmi: 0,
        monthlyHoa: 0,
      );

      expect(result.loanAmount, 0);
      expect(result.principalAndInterest, 0);
    });
  });
}
