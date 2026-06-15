import 'dart:math' as math;

class MortgageCalculation {
  const MortgageCalculation({
    required this.loanAmount,
    required this.principalAndInterest,
    required this.monthlyTaxes,
    required this.monthlyInsurance,
    required this.pmi,
    required this.hoa,
  });

  final double loanAmount;
  final double principalAndInterest;
  final double monthlyTaxes;
  final double monthlyInsurance;
  final double pmi;
  final double hoa;

  double get totalMonthlyPayment =>
      principalAndInterest + monthlyTaxes + monthlyInsurance + pmi + hoa;
}

abstract final class MortgageCalculatorModel {
  static MortgageCalculation calculate({
    required double homePrice,
    required double downPayment,
    required double annualInterestRate,
    required int termYears,
    required double annualPropertyTax,
    required double annualHomeInsurance,
    required double monthlyPmi,
    required double monthlyHoa,
  }) {
    final loanAmount = math.max(0, homePrice - downPayment).toDouble();
    final numberOfPayments = termYears * 12;
    final monthlyRate = annualInterestRate / 100 / 12;

    final principalAndInterest = loanAmount == 0
        ? 0.0
        : monthlyRate == 0
        ? loanAmount / numberOfPayments
        : loanAmount *
              (monthlyRate * math.pow(1 + monthlyRate, numberOfPayments)) /
              (math.pow(1 + monthlyRate, numberOfPayments) - 1);

    return MortgageCalculation(
      loanAmount: loanAmount,
      principalAndInterest: principalAndInterest,
      monthlyTaxes: math.max(0, annualPropertyTax) / 12,
      monthlyInsurance: math.max(0, annualHomeInsurance) / 12,
      pmi: math.max(0, monthlyPmi).toDouble(),
      hoa: math.max(0, monthlyHoa).toDouble(),
    );
  }
}
