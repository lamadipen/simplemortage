import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Simple Mortgage LLC, residential mortgage solutions',
      image: true,
      child: SizedBox(
        width: compact ? 190 : 290,
        height: compact ? 60 : 94,
        child: Image.asset(
          'assets/branding/simple_mortgage_logo.png',
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
          filterQuality: FilterQuality.high,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
