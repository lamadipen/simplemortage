import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class TrustBar extends StatelessWidget {
  const TrustBar({super.key});

  static const items = [
    (
      Icons.bolt_rounded,
      'Fast closing',
      'A focused process that keeps your timeline moving.',
    ),
    (
      Icons.fact_check_rounded,
      'Transparent process',
      'Clear updates, honest answers, and no hidden surprises.',
    ),
    (
      Icons.location_on_rounded,
      'Local guidance',
      'Expertise from people who know the market.',
    ),
    (
      Icons.support_agent_rounded,
      'Personal support',
      'Responsive, one-on-one help whenever you need it.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final mobile = screenWidth < 600;
    final tablet = screenWidth >= 600 && screenWidth < 1100;
    final gap = mobile ? 14.0 : 18.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyDark, AppColors.navy, Color(0xFF31679F)],
          stops: [0, 0.56, 1],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -100,
            right: -30,
            child: _BackgroundGlow(size: 270),
          ),
          const Positioned(
            bottom: -130,
            left: 100,
            child: _BackgroundGlow(size: 240),
          ),
          SectionContainer(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 20 : 48,
              vertical: mobile ? 34 : 42,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = mobile ? 1 : (tablet ? 2 : 4);
                final cardWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final item in items)
                      SizedBox(
                        width: cardWidth,
                        child: _TrustItem(item: item),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.035),
        ),
      ),
    );
  }
}

class _TrustItem extends StatefulWidget {
  const _TrustItem({required this.item});

  final (IconData, String, String) item;

  @override
  State<_TrustItem> createState() => _TrustItemState();
}

class _TrustItemState extends State<_TrustItem> {
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
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          constraints: const BoxConstraints(minHeight: 126),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.13 : 0.085),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: _hovered ? 0.28 : 0.16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.18 : 0.1),
                blurRadius: _hovered ? 24 : 16,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFC74446), AppColors.redDark],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.red.withValues(alpha: 0.34),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Icon(widget.item.$1, color: AppColors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.$2,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.item.$3,
                        style: const TextStyle(
                          color: Color(0xFFD5E1EC),
                          fontSize: 14,
                          height: 1.42,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
