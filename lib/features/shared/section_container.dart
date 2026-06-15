import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/shared/responsive_layout.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.child,
    super.key,
    this.backgroundColor,
    this.padding,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final horizontal = horizontalPagePadding(context);
    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: Padding(
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: MediaQuery.sizeOf(context).width < 600 ? 68 : 96,
            ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Breakpoints.contentMax),
            child: child,
          ),
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.description,
    super.key,
    this.centered = true,
    this.maxWidth = 680,
    this.light = false,
  });

  final String eyebrow;
  final String title;
  final String description;
  final bool centered;
  final double maxWidth;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    final alignment = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.left;
    return Align(
      alignment: centered ? Alignment.center : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: AppTextStyles.label.copyWith(
                color: light ? const Color(0xFFE98B8D) : null,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: textAlign,
              style: AppTextStyles.sectionTitle.copyWith(
                fontSize: compact ? 32 : null,
                color: light ? Colors.white : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: textAlign,
              style: AppTextStyles.body.copyWith(
                color: light ? const Color(0xFFB5C5CF) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
