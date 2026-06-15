import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({required this.onTalkToOfficer, super.key});

  final VoidCallback onTalkToOfficer;

  static const services = [
    (
      Icons.home_work_outlined,
      'Conventional Loans',
      'Flexible financing for qualified buyers, with options for primary homes, second homes, and investment properties.',
      'Flexible terms',
    ),
    (
      Icons.savings_outlined,
      'FHA Loans',
      'Government-backed financing designed to make homeownership more accessible with flexible qualification options.',
      'Accessible options',
    ),
    (
      Icons.military_tech_outlined,
      'VA Loans',
      'Valuable home loan benefits for eligible service members, veterans, and surviving spouses.',
      'For those who served',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SectionContainer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'Loan options',
            title: 'Financing built around your next move',
            description:
                'We explain the tradeoffs in plain English, then help you choose '
                'a mortgage that fits your goals and budget.',
          ),
          const SizedBox(height: 44),
          if (width > 840)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < services.length; i++) ...[
                  Expanded(
                    child: _ServiceCard(
                      service: services[i],
                      onTap: onTalkToOfficer,
                    ),
                  ),
                  if (i < services.length - 1) const SizedBox(width: 20),
                ],
              ],
            )
          else
            Column(
              children: [
                for (final service in services) ...[
                  _ServiceCard(service: service, onTap: onTalkToOfficer),
                  const SizedBox(height: 16),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({required this.service, required this.onTap});

  final (IconData, String, String, String) service;
  final VoidCallback onTap;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: hovered ? AppColors.blue : AppColors.line),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.blueLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(widget.service.$1, color: AppColors.blue),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.redLight,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    widget.service.$4,
                    style: const TextStyle(
                      color: AppColors.redDark,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Text(widget.service.$2, style: AppTextStyles.cardTitle),
            const SizedBox(height: 12),
            Text(widget.service.$3, style: AppTextStyles.body),
            const SizedBox(height: 22),
            TextButton.icon(
              onPressed: widget.onTap,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blue,
                padding: EdgeInsets.zero,
                textStyle: const TextStyle(fontWeight: FontWeight.w800),
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward_rounded, size: 17),
              label: const Text('Talk to a loan officer'),
            ),
          ],
        ),
      ),
    );
  }
}
