import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/brand_logo.dart';
import 'package:simple_mortgage/features/shared/link_utils.dart';
import 'package:simple_mortgage/features/shared/primary_button.dart';
import 'package:simple_mortgage/features/shared/responsive_layout.dart';

class NavItem {
  const NavItem(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;
}

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({
    required this.items,
    required this.onQuote,
    required this.onMenu,
    super.key,
  });

  final List<NavItem> items;
  final VoidCallback onQuote;
  final VoidCallback onMenu;

  // Scaffold caps the app bar at this height; the bar itself is 72 on
  // narrower screens and the body starts wherever it actually ends.
  @override
  Size get preferredSize => const Size.fromHeight(84);

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width > 1320;
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: desktop ? 84 : 72,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPagePadding(context),
        ),
        // The fill must live on the decoration: a BoxShadow paints under the
        // box too, and would tint the bar grey around the white logo.
        decoration: BoxDecoration(
          color: AppColors.white,
          border: const Border(
            top: BorderSide(color: AppColors.red, width: 3),
            bottom: BorderSide(color: AppColors.line),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navyDark.withValues(alpha: 0.10),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1344),
            child: Row(
              children: [
                const _BrandMark(),
                const Spacer(),
                if (desktop) ...[
                  for (final item in items)
                    _NavLink(label: item.label, onTap: item.onTap),
                  const SizedBox(width: 14),
                  PrimaryButton(
                    label: 'Quick Quote',
                    onPressed: onQuote,
                    style: ButtonStyleType.secondary,
                  ),
                  const SizedBox(width: 10),
                  PrimaryButton(
                    label: 'Apply Now',
                    onPressed: () => openLink(AppConstants.applyUrl),
                    icon: Icons.arrow_outward_rounded,
                  ),
                ] else
                  Semantics(
                    button: true,
                    label: 'Open navigation menu',
                    child: IconButton(
                      onPressed: onMenu,
                      icon: const Icon(Icons.menu_rounded),
                      color: AppColors.navy,
                      iconSize: 30,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return const BrandLogo(compact: true);
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: hovered ? AppColors.blue : AppColors.navy,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        child: Text(widget.label),
      ),
    );
  }
}
