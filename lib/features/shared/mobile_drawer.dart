import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/app_navbar.dart';
import 'package:simple_mortgage/features/shared/link_utils.dart';
import 'package:simple_mortgage/features/shared/primary_button.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({required this.items, required this.onQuote, super.key});

  final List<NavItem> items;
  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Simple Mortgage LLC',
                      style: TextStyle(
                        color: AppColors.navyDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close menu',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const Divider(height: 32),
              for (final item in items)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  title: Text(
                    item.label,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_rounded, size: 18),
                  onTap: () {
                    Navigator.pop(context);
                    item.onTap();
                  },
                ),
              const Spacer(),
              PrimaryButton(
                label: 'Get a Quick Quote',
                expand: true,
                onPressed: () {
                  Navigator.pop(context);
                  onQuote();
                },
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Apply Now',
                expand: true,
                style: ButtonStyleType.secondary,
                icon: Icons.arrow_outward_rounded,
                onPressed: () => openLink(AppConstants.applyUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
