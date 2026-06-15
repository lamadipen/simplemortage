import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
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
      Icons.handshake_outlined,
      'Dependable',
      'Responsive professionals take ownership and follow through at every step.',
    ),
    (
      Icons.visibility_outlined,
      'Transparent',
      'Clear costs, clear milestones, and straightforward answers throughout.',
    ),
    (
      Icons.favorite_border_rounded,
      'Customer Service',
      'Personal attention from people who understand this is more than paperwork.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 820;
    return SectionContainer(
      backgroundColor: AppColors.navyDark,
      child: Column(
        children: [
          SectionHeading(
            eyebrow: 'Why Simple Mortgage',
            title: 'A process that respects your time',
            description:
                'Mortgage guidance should feel organized, understandable, and '
                'personal from the first conversation to closing.',
            maxWidth: 720,
            light: true,
          ),
          const SizedBox(height: 46),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  Expanded(
                    child: _WhyCard(item: items[i], number: i + 1),
                  ),
                  if (i < items.length - 1) const SizedBox(width: 16),
                ],
              ],
            )
          else
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (var i = 0; i < items.length; i++)
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width < 600
                        ? double.infinity
                        : (MediaQuery.sizeOf(context).width - 88) / 2,
                    child: _WhyCard(item: items[i], number: i + 1),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  const _WhyCard({required this.item, required this.number});

  final (IconData, String, String) item;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.$1, color: AppColors.gold, size: 21),
              ),
              Text(
                number.toString().padLeft(2, '0'),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.16),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            item.$2,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.$3,
            style: const TextStyle(
              color: Color(0xFFB5C5CF),
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
