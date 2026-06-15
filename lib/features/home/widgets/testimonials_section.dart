import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const reviews = [
    (
      'PP',
      'P. Pandit',
      'Wonderful experience',
      'The team went above and beyond with their customer service. The process '
          'was smooth, fast, and professional from beginning to end.',
    ),
    (
      'GB',
      'G. Basnet',
      'Prompt and dependable',
      'I was very satisfied with the prompt loan processing and communication '
          'at every level. The entire experience was smooth and hassle-free.',
    ),
    (
      'IY',
      'I. Yadav',
      'Supported at every step',
      'The team was responsive and attentive throughout the process. They '
          'answered my questions clearly and made the application straightforward.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 840;
    return SectionContainer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'Client stories',
            title: 'Trusted for clear, personal guidance',
            description:
                'Home financing can feel complicated. Our clients remember how '
                'we communicated, followed through, and made it feel manageable.',
          ),
          const SizedBox(height: 44),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < reviews.length; i++) ...[
                  Expanded(child: _ReviewCard(review: reviews[i])),
                  if (i < reviews.length - 1) const SizedBox(width: 20),
                ],
              ],
            )
          else
            Column(
              children: [
                for (final review in reviews) ...[
                  _ReviewCard(review: review),
                  const SizedBox(height: 16),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final (String, String, String, String) review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (var i = 0; i < 5; i++)
                const Icon(Icons.star_rounded, color: AppColors.red, size: 19),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            '“${review.$4}”',
            style: const TextStyle(
              color: AppColors.navyDark,
              fontSize: 16,
              height: 1.65,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.navy,
                child: Text(
                  review.$1,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.navyDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.$3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
