import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/calculator/mortgage_calculator_model.dart';

class MortgageCalculator extends StatefulWidget {
  const MortgageCalculator({super.key});

  @override
  State<MortgageCalculator> createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  final _homePrice = TextEditingController(text: '450,000');
  final _downPayment = TextEditingController(text: '90,000');
  final _interestRate = TextEditingController(text: '6.50');
  final _propertyTax = TextEditingController(text: '5,400');
  final _insurance = TextEditingController(text: '1,800');
  final _pmi = TextEditingController(text: '0');
  final _hoa = TextEditingController(text: '0');
  int _termYears = 30;

  @override
  void initState() {
    super.initState();
    for (final controller in _controllers) {
      controller.addListener(_refresh);
    }
  }

  List<TextEditingController> get _controllers => [
    _homePrice,
    _downPayment,
    _interestRate,
    _propertyTax,
    _insurance,
    _pmi,
    _hoa,
  ];

  double _value(TextEditingController controller) =>
      double.tryParse(controller.text.replaceAll(',', '')) ?? 0;

  void _refresh() {
    if (mounted) setState(() {});
  }

  MortgageCalculation get _calculation => MortgageCalculatorModel.calculate(
    homePrice: _value(_homePrice),
    downPayment: _value(_downPayment),
    annualInterestRate: _value(_interestRate),
    termYears: _termYears,
    annualPropertyTax: _value(_propertyTax),
    annualHomeInsurance: _value(_insurance),
    monthlyPmi: _value(_pmi),
    monthlyHoa: _value(_hoa),
  );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller
        ..removeListener(_refresh)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stacked = MediaQuery.sizeOf(context).width < 900;
    final inputs = _CalculatorInputs(
      homePrice: _homePrice,
      downPayment: _downPayment,
      interestRate: _interestRate,
      propertyTax: _propertyTax,
      insurance: _insurance,
      pmi: _pmi,
      hoa: _hoa,
      termYears: _termYears,
      onTermChanged: (value) => setState(() => _termYears = value),
    );
    final results = _ResultCard(calculation: _calculation);

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.line),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withValues(alpha: 0.07),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(stacked ? 20 : 30),
            child: stacked
                ? Column(
                    children: [inputs, const SizedBox(height: 22), results],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: inputs),
                      const SizedBox(width: 28),
                      Expanded(flex: 4, child: results),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'This calculator is for estimation only and does not represent a loan '
          'approval, rate quote, or commitment to lend.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.muted, fontSize: 13, height: 1.5),
        ),
      ],
    );
  }
}

class _CalculatorInputs extends StatelessWidget {
  const _CalculatorInputs({
    required this.homePrice,
    required this.downPayment,
    required this.interestRate,
    required this.propertyTax,
    required this.insurance,
    required this.pmi,
    required this.hoa,
    required this.termYears,
    required this.onTermChanged,
  });

  final TextEditingController homePrice;
  final TextEditingController downPayment;
  final TextEditingController interestRate;
  final TextEditingController propertyTax;
  final TextEditingController insurance;
  final TextEditingController pmi;
  final TextEditingController hoa;
  final int termYears;
  final ValueChanged<int> onTermChanged;

  @override
  Widget build(BuildContext context) {
    final singleColumn = MediaQuery.sizeOf(context).width < 620;
    final fields = <Widget>[
      _NumberField(label: 'Home price', controller: homePrice, currency: true),
      _NumberField(
        label: 'Down payment',
        controller: downPayment,
        currency: true,
      ),
      _NumberField(
        label: 'Interest rate',
        controller: interestRate,
        suffix: '%',
        decimal: true,
      ),
      _TermField(value: termYears, onChanged: onTermChanged),
      _NumberField(
        label: 'Property tax / year',
        controller: propertyTax,
        currency: true,
      ),
      _NumberField(
        label: 'Home insurance / year',
        controller: insurance,
        currency: true,
      ),
      _NumberField(label: 'PMI / month', controller: pmi, currency: true),
      _NumberField(label: 'HOA / month', controller: hoa, currency: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your loan details', style: AppTextStyles.cardTitle),
        const SizedBox(height: 8),
        const Text(
          'Adjust any value to update your estimate instantly.',
          style: TextStyle(color: AppColors.muted, height: 1.45),
        ),
        const SizedBox(height: 24),
        if (singleColumn)
          ...fields.expand((field) => [field, const SizedBox(height: 16)])
        else
          for (var index = 0; index < fields.length; index += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: fields[index]),
                  const SizedBox(width: 16),
                  Expanded(child: fields[index + 1]),
                ],
              ),
            ),
      ],
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.controller,
    this.currency = false,
    this.decimal = false,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final bool currency;
  final bool decimal;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      inputFormatters: [
        if (currency) CurrencyInputFormatter(),
        if (decimal)
          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,3})?')),
      ],
      decoration: InputDecoration(
        labelText: label,
        prefixText: currency ? r'$ ' : null,
        suffixText: suffix,
      ),
      validator: (value) {
        final parsed = double.tryParse((value ?? '').replaceAll(',', ''));
        if (parsed == null || parsed < 0) return 'Enter a valid amount';
        return null;
      },
    );
  }
}

class _TermField extends StatelessWidget {
  const _TermField({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'Loan term'),
      items: const [
        DropdownMenuItem(value: 15, child: Text('15 years')),
        DropdownMenuItem(value: 20, child: Text('20 years')),
        DropdownMenuItem(value: 30, child: Text('30 years')),
      ],
      onChanged: (newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.calculation});

  final MortgageCalculation calculation;

  @override
  Widget build(BuildContext context) {
    final rows = <(String, double)>[
      ('Principal & interest', calculation.principalAndInterest),
      ('Property taxes', calculation.monthlyTaxes),
      ('Home insurance', calculation.monthlyInsurance),
      ('PMI', calculation.pmi),
      ('HOA', calculation.hoa),
    ];

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calculate_outlined, color: AppColors.red),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Estimated Monthly Payment',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            formatCurrency(calculation.totalMonthlyPayment),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 42,
              height: 1,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'per month',
            style: TextStyle(color: Color(0xFFB8CBD8), fontSize: 14),
          ),
          const SizedBox(height: 24),
          _PaymentComposition(calculation: calculation),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 22),
            child: Divider(color: Color(0xFF355168), height: 1),
          ),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      row.$1,
                      style: const TextStyle(
                        color: Color(0xFFCFDCE4),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    formatCurrency(row.$2),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 7),
          _LoanAmountSummary(amount: calculation.loanAmount),
        ],
      ),
    );
  }
}

class _LoanAmountSummary extends StatelessWidget {
  const _LoanAmountSummary({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Estimated loan amount ${formatCurrency(amount)}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFC44245), AppColors.redDark],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD96365)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.red.withValues(alpha: 0.22),
              blurRadius: 20,
              spreadRadius: -4,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact =
                MediaQuery.sizeOf(context).width < 600 ||
                constraints.maxWidth < 310;
            final heading = Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                    ),
                  ),
                  child: const Icon(
                    Icons.account_balance_rounded,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ESTIMATED LOAN AMOUNT',
                        style: TextStyle(
                          color: Color(0xFFFFDCDD),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Home price minus down payment',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            final value = Text(
              formatCurrency(amount),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [heading, const SizedBox(height: 14), value],
              );
            }

            return Row(
              children: [
                Expanded(child: heading),
                const SizedBox(width: 12),
                value,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PaymentComposition extends StatelessWidget {
  const _PaymentComposition({required this.calculation});

  final MortgageCalculation calculation;

  @override
  Widget build(BuildContext context) {
    final total = calculation.totalMonthlyPayment;
    final values = [
      calculation.principalAndInterest,
      calculation.monthlyTaxes + calculation.monthlyInsurance,
      calculation.pmi + calculation.hoa,
    ];
    const colors = [AppColors.red, Color(0xFF6EA1D2), Color(0xFFD6E4F1)];
    const labels = ['P&I', 'Tax + insurance', 'PMI + HOA'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 10,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: [
                    for (var index = 0; index < values.length; index++)
                      Container(
                        width: total <= 0
                            ? constraints.maxWidth / values.length
                            : constraints.maxWidth * values[index] / total,
                        color: colors[index],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 14,
          runSpacing: 7,
          children: [
            for (var index = 0; index < labels.length; index++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: colors[index],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    labels[index],
                    style: const TextStyle(
                      color: Color(0xFFB8CBD8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }
    final formatted = _withCommas(digits);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String formatCurrency(double value) {
  final rounded = value.round().toString();
  return '\$${_withCommas(rounded)}';
}

String _withCommas(String digits) {
  return digits.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
}
