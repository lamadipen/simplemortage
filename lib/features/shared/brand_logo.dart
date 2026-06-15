import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final markSize = compact ? 40.0 : 48.0;
    return Semantics(
      label: 'Simple Mortgage LLC, residential mortgage solutions',
      image: true,
      child: SizedBox(
        width: compact ? 182 : 226,
        height: compact ? 44 : 52,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: Size(markSize, markSize),
                painter: const _HouseLogoPainter(),
              ),
              SizedBox(width: compact ? 8 : 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SIMPLE MORTGAGE LLC',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: compact ? 14 : 16,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      letterSpacing: compact ? 0.35 : 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Residential mortgage solutions',
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: compact ? 9 : 10,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HouseLogoPainter extends CustomPainter {
  const _HouseLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()..color = AppColors.blue;
    final red = Paint()..color = AppColors.red;
    final white = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.045
      ..style = PaintingStyle.stroke;

    final roof = Path()
      ..moveTo(size.width * 0.08, size.height * 0.42)
      ..lineTo(size.width * 0.5, size.height * 0.1)
      ..lineTo(size.width * 0.92, size.height * 0.42)
      ..lineTo(size.width * 0.84, size.height * 0.5)
      ..lineTo(size.width * 0.5, size.height * 0.24)
      ..lineTo(size.width * 0.16, size.height * 0.5)
      ..close();
    canvas.drawPath(roof, blue);

    final house = Path()
      ..moveTo(size.width * 0.2, size.height * 0.43)
      ..lineTo(size.width * 0.5, size.height * 0.2)
      ..lineTo(size.width * 0.8, size.height * 0.43)
      ..lineTo(size.width * 0.8, size.height * 0.9)
      ..lineTo(size.width * 0.2, size.height * 0.9)
      ..close();
    canvas.drawPath(house, red);

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.57,
        size.height * 0.62,
        size.width * 0.13,
        size.height * 0.28,
      ),
      Paint()..color = AppColors.navyDark,
    );

    final monogram = TextPainter(
      text: TextSpan(
        text: 'SM',
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.3,
          height: 1,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    monogram.paint(canvas, Offset(size.width * 0.22, size.height * 0.52));

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.31),
      Offset(size.width * 0.5, size.height * 0.41),
      white,
    );
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.36),
      Offset(size.width * 0.55, size.height * 0.36),
      white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
