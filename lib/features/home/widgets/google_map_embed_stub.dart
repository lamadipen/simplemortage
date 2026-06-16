import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';

class GoogleMapEmbed extends StatelessWidget {
  const GoogleMapEmbed({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.blueLight,
      child: Center(
        child: Icon(Icons.map_outlined, color: AppColors.blue, size: 52),
      ),
    );
  }
}
