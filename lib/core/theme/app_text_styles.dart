import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';

abstract final class AppTextStyles {
  static const display = TextStyle(
    color: AppColors.navyDark,
    fontSize: 58,
    height: 1.04,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.2,
  );

  static const sectionTitle = TextStyle(
    color: AppColors.navyDark,
    fontSize: 42,
    height: 1.12,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.2,
  );

  static const cardTitle = TextStyle(
    color: AppColors.navyDark,
    fontSize: 23,
    height: 1.25,
    fontWeight: FontWeight.w700,
  );

  static const body = TextStyle(
    color: AppColors.slate,
    fontSize: 17,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  static const label = TextStyle(
    color: AppColors.blue,
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.3,
  );
}
