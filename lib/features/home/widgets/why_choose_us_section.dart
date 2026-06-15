import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({super.key});

  static const items = [
    (
      Icons.bolt_rounded,
      'Speed and Control',
      'We keep your file moving and work toward closing on or before schedule.',
    ),
    (
      Icons.handshake_rounded,
      'Dependable',
      'Responsive professionals take ownership and follow through at every step.',
    ),
    (
      Icons.fact_check_rounded,
      'Transparent',
      'Clear costs, clear milestones, and straightforward answers throughout.',
    ),
    (
      Icons.favorite_rounded,
      'Customer Service',
      'Personal attention from people who understand this is more than paperwork.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 600;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF112F50), AppColors.navyDark, Color(0xFF285B8F)],
          stops: [0, 0.55, 1],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -170,
            left: -90,
            child: _SectionGlow(size: 380),
          ),
          const Positioned(
            right: -120,
            bottom: -190,
            child: _SectionGlow(size: 430),
          ),
          SectionContainer(
            child: Column(
              children: [
                const _WhyHeading(),
                SizedBox(height: mobile ? 38 : 50),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 1000
                        ? 4
                        : constraints.maxWidth >= 600
                        ? 2
                        : 1;
                    final gap = mobile ? 14.0 : 18.0;
                    final cardWidth =
                        (constraints.maxWidth - gap * (columns - 1)) / columns;

                    return Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      children: [
                        for (var index = 0; index < items.length; index++)
                          SizedBox(
                            width: cardWidth,
                            child: _WhyCard(
                              item: items[index],
                              number: index + 1,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhyHeading extends StatelessWidget {
  const _WhyHeading();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 760),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.red.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color(0xFFFFA4A6).withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: Color(0xFFFFA4A6),
                  size: 17,
                ),
                SizedBox(width: 8),
                Text(
                  'WHY SIMPLE MORTGAGE',
                  style: TextStyle(
                    color: Color(0xFFFFB4B5),
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'A process that respects your time',
            textAlign: TextAlign.center,
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.white,
              fontSize: compact ? 36 : 44,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'Mortgage guidance should feel organized, understandable, and '
            'personal from the first conversation to closing.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFD3E0EA),
              fontSize: 17,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionGlow extends StatelessWidget {
  const _SectionGlow({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.025),
        ),
      ),
    );
  }
}

class _WhyCard extends StatefulWidget {
  const _WhyCard({required this.item, required this.number});

  final (IconData, String, String) item;
  final int number;

  @override
  State<_WhyCard> createState() => _WhyCardState();
}

class _WhyCardState extends State<_WhyCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '${widget.item.$2}. ${widget.item.$3}',
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          constraints: const BoxConstraints(minHeight: 258),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.13 : 0.085),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: _hovered ? 0.28 : 0.16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.2 : 0.11),
                blurRadius: _hovered ? 28 : 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFC74446), AppColors.redDark],
                      ),
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.red.withValues(alpha: 0.38),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.item.$1,
                      color: AppColors.white,
                      size: 29,
                    ),
                  ),
                  Text(
                    widget.number.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.22),
                      fontSize: 31,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                widget.item.$2,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 11),
              Text(
                widget.item.$3,
                style: const TextStyle(
                  color: Color(0xFFD3E0EA),
                  fontSize: 15,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
