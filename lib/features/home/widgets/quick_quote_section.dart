import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/calculator/mortgage_calculator.dart';
import 'package:simple_mortgage/features/shared/primary_button.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class QuoteRequest {
  const QuoteRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.homePrice,
    required this.downPayment,
    required this.loanAmount,
    required this.creditRange,
    required this.message,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String homePrice;
  final String downPayment;
  final String loanAmount;
  final String creditRange;
  final String message;
}

abstract interface class QuoteSubmissionService {
  Future<void> submit(QuoteRequest request);
}

class MockQuoteSubmissionService implements QuoteSubmissionService {
  @override
  Future<void> submit(QuoteRequest request) =>
      Future<void>.delayed(const Duration(milliseconds: 650));
}

class QuickQuoteSection extends StatefulWidget {
  const QuickQuoteSection({super.key, this.service});

  final QuoteSubmissionService? service;

  @override
  State<QuickQuoteSection> createState() => _QuickQuoteSectionState();
}

class _QuickQuoteSectionState extends State<QuickQuoteSection> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _homePrice = TextEditingController();
  final _downPayment = TextEditingController();
  final _loanAmount = TextEditingController();
  final _message = TextEditingController();
  String? _creditRange;
  bool _consent = false;
  bool _consentError = false;
  bool _submitting = false;

  @override
  void dispose() {
    for (final controller in [
      _firstName,
      _lastName,
      _email,
      _phone,
      _homePrice,
      _downPayment,
      _loanAmount,
      _message,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;

  String? _validateEmail(String? value) {
    if (_required(value) case final error?) return error;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _consentError = !_consent);
    if (!valid || !_consent) return;

    setState(() => _submitting = true);
    final request = QuoteRequest(
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      homePrice: _homePrice.text,
      downPayment: _downPayment.text,
      loanAmount: _loanAmount.text,
      creditRange: _creditRange!,
      message: _message.text.trim(),
    );
    await (widget.service ?? MockQuoteSubmissionService()).submit(request);
    if (!mounted) return;
    setState(() => _submitting = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Thanks! Your quote request has been received. We’ll be in touch soon.',
        ),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    _formKey.currentState?.reset();
    for (final controller in [
      _firstName,
      _lastName,
      _email,
      _phone,
      _homePrice,
      _downPayment,
      _loanAmount,
      _message,
    ]) {
      controller.clear();
    }
    setState(() {
      _creditRange = null;
      _consent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width > 900;
    return SectionContainer(
      backgroundColor: AppColors.blueLight,
      child: desktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 4, child: _QuoteIntro()),
                const SizedBox(width: 64),
                Expanded(flex: 6, child: _buildForm()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _QuoteIntro(),
                const SizedBox(height: 38),
                _buildForm(),
              ],
            ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(
          MediaQuery.sizeOf(context).width < 600 ? 20 : 30,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: 0.08),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          children: [
            _FormRow(
              children: [
                TextFormField(
                  controller: _firstName,
                  decoration: const InputDecoration(labelText: 'First name *'),
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.givenName],
                  validator: _required,
                ),
                TextFormField(
                  controller: _lastName,
                  decoration: const InputDecoration(labelText: 'Last name *'),
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.familyName],
                  validator: _required,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _FormRow(
              children: [
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email *'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: _validateEmail,
                ),
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(labelText: 'Phone *'),
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9()+\-\s]')),
                  ],
                  validator: (value) {
                    if (_required(value) case final error?) return error;
                    final digits = value!.replaceAll(RegExp(r'\D'), '');
                    return digits.length < 10 ? 'Enter a valid phone' : null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _FormRow(
              children: [
                _MoneyField(label: 'Home price', controller: _homePrice),
                _MoneyField(label: 'Down payment', controller: _downPayment),
              ],
            ),
            const SizedBox(height: 16),
            _FormRow(
              children: [
                _MoneyField(label: 'Loan amount', controller: _loanAmount),
                DropdownButtonFormField<String>(
                  initialValue: _creditRange,
                  decoration: const InputDecoration(
                    labelText: 'Credit score range *',
                  ),
                  items: const [
                    DropdownMenuItem(value: '760+', child: Text('760+')),
                    DropdownMenuItem(value: '700-759', child: Text('700–759')),
                    DropdownMenuItem(value: '660-699', child: Text('660–699')),
                    DropdownMenuItem(value: '620-659', child: Text('620–659')),
                    DropdownMenuItem(
                      value: 'Below 620',
                      child: Text('Below 620'),
                    ),
                    DropdownMenuItem(
                      value: 'Unsure',
                      child: Text('I’m not sure'),
                    ),
                  ],
                  onChanged: (value) => setState(() => _creditRange = value),
                  validator: (value) =>
                      value == null ? 'Select a credit range' : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _message,
              decoration: const InputDecoration(
                labelText: 'How can we help? (optional)',
                alignLabelWithHint: true,
              ),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 14),
            CheckboxListTile(
              value: _consent,
              onChanged: (value) {
                setState(() {
                  _consent = value ?? false;
                  _consentError = false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.navy,
              title: const Text(
                'I agree to receive calls and emails regarding my inquiry.',
                style: TextStyle(
                  color: AppColors.slate,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              subtitle: _consentError
                  ? const Text(
                      'Consent is required to submit',
                      style: TextStyle(color: Color(0xFFB3261E), fontSize: 12),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: _submitting ? 'Sending…' : 'Get My Quick Quote',
              icon: _submitting ? null : Icons.arrow_forward_rounded,
              expand: true,
              onPressed: _submitting ? () {} : _submit,
            ),
            const SizedBox(height: 12),
            const Text(
              'No API keys or sensitive credentials are stored in this form.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuoteIntro extends StatelessWidget {
  const _QuoteIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('GET STARTED', style: AppTextStyles.label),
        const SizedBox(height: 14),
        Text(
          'A clearer mortgage starts with a conversation.',
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: MediaQuery.sizeOf(context).width < 600 ? 32 : null,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Tell us a little about your plans. A loan professional can help you '
          'understand practical next steps without the pressure.',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 28),
        const _IntroPoint(
          icon: Icons.lock_outline_rounded,
          text: 'Your information stays private',
        ),
        const _IntroPoint(
          icon: Icons.chat_bubble_outline_rounded,
          text: 'Straightforward, human guidance',
        ),
        const _IntroPoint(
          icon: Icons.schedule_rounded,
          text: 'Prompt follow-up from our team',
        ),
      ],
    );
  }
}

class _IntroPoint extends StatelessWidget {
  const _IntroPoint({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormRow extends StatelessWidget {
  const _FormRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 650) {
      return Column(
        children: [children.first, const SizedBox(height: 16), children.last],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: children.first),
        const SizedBox(width: 16),
        Expanded(child: children.last),
      ],
    );
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [CurrencyInputFormatter()],
      decoration: InputDecoration(labelText: '$label *', prefixText: r'$ '),
      validator: (value) =>
          value == null || value.isEmpty ? 'This field is required' : null,
    );
  }
}
