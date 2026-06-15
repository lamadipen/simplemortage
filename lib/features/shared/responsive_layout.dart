import 'package:flutter/widgets.dart';

abstract final class Breakpoints {
  static const mobile = 600.0;
  static const desktop = 1024.0;
  static const contentMax = 1200.0;
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < Breakpoints.mobile) return mobile;
    if (width <= Breakpoints.desktop) return tablet;
    return desktop;
  }
}

double horizontalPagePadding(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < Breakpoints.mobile) return 20;
  if (width <= Breakpoints.desktop) return 36;
  return 48;
}
