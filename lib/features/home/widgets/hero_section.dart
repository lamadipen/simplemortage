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
                  fontSize: 12,
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
                ? 43
                : desktop
                ? 64
                : 52,
            height: 0.98,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'We help homebuyers and homeowners navigate Conventional, FHA, and '
          'VA loans with a simple, prompt, and transparent process.',
          style: AppTextStyles.body.copyWith(fontSize: mobile ? 18 : 19),
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
              fontSize: 12,
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
          height: 500,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withValues(alpha: 0.16),
                blurRadius: 34,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/branding/homebuyer-hero.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                filterQuality: FilterQuality.medium,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0x17000000),
                      Color(0x8A173A61),
                    ],
                    stops: [0.35, 0.65, 1],
                  ),
                ),
              ),
              const Positioned(left: 24, top: 24, child: _PhotoLabel()),
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
          right: -8,
          top: 36,
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
                  'Local mortgage guidance',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
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

class _PhotoLabel extends StatelessWidget {
  const _PhotoLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.key_rounded, color: AppColors.red, size: 16),
          SizedBox(width: 7),
          Text(
            'YOUR NEXT CHAPTER',
            style: TextStyle(
              color: AppColors.navyDark,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ],
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
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 11),
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
