import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';

enum ButtonStyleType { primary, secondary, light }

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.style = ButtonStyleType.primary,
    this.expand = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final ButtonStyleType style;
  final bool expand;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.style == ButtonStyleType.primary;
    final isLight = widget.style == ButtonStyleType.light;
    final background = isPrimary
        ? (_hovered ? AppColors.redDark : AppColors.red)
        : isLight
        ? AppColors.white
        : (_hovered ? AppColors.redLight : Colors.transparent);
    final foreground = isPrimary
        ? AppColors.white
        : isLight
        ? AppColors.navy
        : AppColors.red;
    final button = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        child: FilledButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon == null
              ? const SizedBox.shrink()
              : Icon(widget.icon, size: 18),
          label: Text(widget.label),
          style: FilledButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            elevation: isPrimary && _hovered ? 4 : 0,
            shadowColor: AppColors.red.withValues(alpha: 0.22),
            side: isPrimary || isLight
                ? BorderSide.none
                : const BorderSide(color: AppColors.red),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
    return widget.expand
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
