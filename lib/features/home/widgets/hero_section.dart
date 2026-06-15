import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/shared/primary_button.dart';
import 'package:simple_mortgage/features/shared/responsive_layout.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.onCalculator,
    required this.onQuote,
    super.key,
  });

  final VoidCallback onCalculator;
  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width > Breakpoints.desktop;
    final mobile = width < Breakpoints.mobile;
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.redLight,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, color: AppColors.red, size: 17),
              SizedBox(width: 7),
              Text(
                'LOCAL GUIDANCE. CLEAR ANSWERS.',
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Simple Mortgage Solutions for Your Dream Home',
          style: AppTextStyles.display.copyWith(
            fontSize: mobile
                ? 42
                : desktop
                ? 62
                : 52,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'We help homebuyers and homeowners navigate Conventional, FHA, and '
          'VA loans with a simple, prompt, and transparent process.',
          style: AppTextStyles.body.copyWith(fontSize: mobile ? 17 : 18),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'Calculate Payment',
              icon: Icons.calculate_outlined,
              onPressed: onCalculator,
            ),
            PrimaryButton(
              label: 'Get Quick Quote',
              style: ButtonStyleType.secondary,
              icon: Icons.arrow_forward_rounded,
              onPressed: onQuote,
            ),
          ],
        ),
        const SizedBox(height: 34),
        const Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _TrustBadge(icon: Icons.gavel_rounded, label: 'Licensed Broker'),
            _TrustBadge(icon: Icons.badge_outlined, label: 'NMLS 1951072'),
            _TrustBadge(
              icon: Icons.location_on_outlined,
              label: 'Serving VA, MD, NC, OH & PA',
            ),
          ],
        ),
      ],
    );

    return SectionContainer(
      padding: EdgeInsets.fromLTRB(
        horizontalPagePadding(context),
        desktop ? 92 : 62,
        horizontalPagePadding(context),
        desktop ? 104 : 72,
      ),
      child: desktop
          ? Row(
              children: [
                Expanded(flex: 11, child: copy),
                const SizedBox(width: 72),
                const Expanded(flex: 9, child: _LoanVisual()),
              ],
            )
          : Column(
              children: [copy, const SizedBox(height: 52), const _LoanVisual()],
            ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.blue),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.slate,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoanVisual extends StatelessWidget {
  const _LoanVisual();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 430,
          decoration: BoxDecoration(
            color: AppColors.blueLight,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -70,
                right: -40,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Positioned.fill(child: _HouseIllustration()),
            ],
          ),
        ),
        Positioned(
          left: 22,
          right: 22,
          bottom: 22,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withValues(alpha: 0.13),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Row(
              children: [
                _VisualMetric(value: 'Clear', label: 'loan options'),
                _VerticalLine(),
                _VisualMetric(value: 'Local', label: 'expert guidance'),
                _VerticalLine(),
                _VisualMetric(value: 'Prompt', label: 'communication'),
              ],
            ),
          ),
        ),
        Positioned(
          right: -10,
          top: 32,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.red.withValues(alpha: 0.24),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 17),
                SizedBox(width: 7),
                Text(
                  'A simpler path home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HouseIllustration extends StatelessWidget {
  const _HouseIllustration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 62),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 245,
              height: 180,
              margin: const EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.09),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
            ),
            Transform.rotate(
              angle: 0.785398,
              child: Container(
                width: 174,
                height: 174,
                margin: const EdgeInsets.only(bottom: 67),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: 113,
              child: Container(
                width: 210,
                height: 132,
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 55,
                      height: 76,
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 22),
                        child: Icon(
                          Icons.lock_open_rounded,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 55,
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        color: AppColors.blueLight,
                        border: Border.all(color: AppColors.blue, width: 5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisualMetric extends StatelessWidget {
  const _VisualMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _VerticalLine extends StatelessWidget {
  const _VerticalLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 38, color: AppColors.line);
  }
}
