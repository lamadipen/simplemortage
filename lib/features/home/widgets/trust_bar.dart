import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class TrustBar extends StatelessWidget {
  const TrustBar({super.key});

  static const items = [
    (
      Icons.speed_rounded,
      'Fast closing',
      'Your timeline stays front and center.',
    ),
    (
      Icons.visibility_outlined,
      'Transparent process',
      'Know what happens next and why.',
    ),
    (
      Icons.location_on_outlined,
      'Local guidance',
      'Fairfax-based mortgage expertise.',
    ),
    (
      Icons.support_agent_rounded,
      'Personal support',
      'Real people, responsive communication.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 760;
    return SectionContainer(
      backgroundColor: AppColors.navy,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
        vertical: 32,
      ),
      child: narrow
          ? Wrap(
              spacing: 12,
              runSpacing: 22,
              children: [
                for (final item in items)
                  SizedBox(
                    width: (MediaQuery.sizeOf(context).width - 52) / 2,
                    child: _TrustItem(item: item),
                  ),
              ],
            )
          : Row(
              children: [
                for (var index = 0; index < items.length; index++) ...[
                  Expanded(child: _TrustItem(item: items[index])),
                  if (index < items.length - 1)
                    Container(
                      width: 1,
                      height: 48,
                      color: Colors.white.withValues(alpha: 0.14),
                    ),
                ],
              ],
            ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({required this.item});

  final (IconData, String, String) item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.$1, color: AppColors.red, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$2,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.$3,
                  style: const TextStyle(
                    color: Color(0xFFADBFCA),
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
