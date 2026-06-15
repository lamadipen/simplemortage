import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/link_utils.dart';
import 'package:simple_mortgage/features/shared/primary_button.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width > 860;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          eyebrow: 'Contact',
          title: 'Local expertise, easy to reach',
          description:
              'Visit our Fairfax office or reach out by phone or email. We’re '
              'here to help you make sense of your mortgage options.',
          centered: false,
        ),
        const SizedBox(height: 34),
        const _ContactRow(
          icon: Icons.location_on_outlined,
          title: 'Fairfax office',
          value: AppConstants.address,
        ),
        const SizedBox(height: 20),
        const _ContactRow(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value:
              '${AppConstants.mobilePhone} mobile\n${AppConstants.officePhone} office',
        ),
        const SizedBox(height: 20),
        const _ContactRow(
          icon: Icons.email_outlined,
          title: 'Email',
          value: AppConstants.email,
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'Call Now',
              icon: Icons.call_rounded,
              onPressed: () => callPhone(AppConstants.mobilePhone),
            ),
            PrimaryButton(
              label: 'Send Email',
              icon: Icons.email_outlined,
              style: ButtonStyleType.secondary,
              onPressed: () => sendEmail(AppConstants.email),
            ),
          ],
        ),
      ],
    );

    return SectionContainer(
      backgroundColor: AppColors.white,
      child: desktop
          ? Row(
              children: [
                Expanded(child: details),
                const SizedBox(width: 60),
                const Expanded(child: _MapCard()),
              ],
            )
          : Column(
              children: [details, const SizedBox(height: 44), const _MapCard()],
            ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.blueLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.blue, size: 21),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.navyDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(color: AppColors.slate, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapCard extends StatelessWidget {
  const _MapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDE8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MapPainter())),
          Center(
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.navy,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.location_on_rounded,
                color: AppColors.gold,
                size: 30,
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.12),
                    blurRadius: 22,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Simple Mortgage LLC',
                          style: TextStyle(
                            color: AppColors.navyDark,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '10304 Eaton Place · Fairfax, VA',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filled(
                    tooltip: 'Open in Google Maps',
                    onPressed: () => openLink(AppConstants.mapUrl),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.navy,
                      foregroundColor: AppColors.white,
                    ),
                    icon: const Icon(Icons.directions_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final minor = Paint()
      ..color = const Color(0xFFD2DDD5)
      ..strokeWidth = 2;
    final road = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;
    final blocks = Paint()..color = const Color(0xFFDAE4DC);

    for (var x = -30.0; x < size.width; x += 78) {
      canvas.drawRect(Rect.fromLTWH(x, 0, 50, size.height), blocks);
      canvas.drawLine(Offset(x + 60, 0), Offset(x + 60, size.height), minor);
    }
    for (var y = 42.0; y < size.height; y += 82) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minor);
    }
    final path = Path()
      ..moveTo(-20, size.height * .25)
      ..cubicTo(
        size.width * .3,
        size.height * .1,
        size.width * .54,
        size.height * .72,
        size.width + 20,
        size.height * .5,
      );
    canvas.drawPath(path, road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
