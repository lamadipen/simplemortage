import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/features/shared/brand_logo.dart';
import 'package:simple_mortgage/features/shared/link_utils.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({
    required this.onServices,
    required this.onCalculator,
    required this.onReviews,
    required this.onTeam,
    required this.onContact,
    super.key,
  });

  final VoidCallback onServices;
  final VoidCallback onCalculator;
  final VoidCallback onReviews;
  final VoidCallback onTeam;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 720;
    final columns = [
      const _CompanyColumn(),
      _LinkColumn(
        title: 'Services',
        links: [
          ('Conventional Loans', onServices),
          ('FHA Loans', onServices),
          ('VA Loans', onServices),
          ('Mortgage Calculator', onCalculator),
        ],
      ),
      _LinkColumn(
        title: 'Quick links',
        links: [
          ('Meet Our Team', onTeam),
          ('Client Reviews', onReviews),
          ('Contact Us', onContact),
          ('Apply Now', () => openLink(AppConstants.applyUrl)),
          ('NMLS Consumer Access', () => openLink(AppConstants.nmlsUrl)),
        ],
      ),
      const _ConnectColumn(),
    ];
    return ColoredBox(
      color: AppColors.navyDark,
      child: Column(
        children: [
          SectionContainer(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
              68,
              MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
              52,
            ),
            child: mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final column in columns) ...[
                        column,
                        const SizedBox(height: 36),
                      ],
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: columns[0]),
                      const SizedBox(width: 40),
                      Expanded(flex: 2, child: columns[1]),
                      Expanded(flex: 2, child: columns[2]),
                      Expanded(flex: 3, child: columns[3]),
                    ],
                  ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.035),
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
              vertical: 32,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 18,
                      runSpacing: 10,
                      children: [
                        for (final license in AppConstants.licenses)
                          Text(
                            license,
                            style: const TextStyle(
                              color: Color(0xFF9AAEBA),
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    const Text(
                      AppConstants.disclaimer,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9AAEBA),
                        fontSize: 11,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '© ${DateTime.now().year} Simple Mortgage LLC. All rights reserved.',
                      style: const TextStyle(
                        color: Color(0xFF718793),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyColumn extends StatelessWidget {
  const _CompanyColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const BrandLogo(),
        ),
        const SizedBox(height: 17),
        const Text(
          'Simple, prompt, and transparent mortgage guidance for homebuyers '
          'and homeowners in Virginia and beyond.',
          style: TextStyle(
            color: Color(0xFF9AAEBA),
            fontSize: 14,
            height: 1.65,
          ),
        ),
      ],
    );
  }
}

class _LinkColumn extends StatelessWidget {
  const _LinkColumn({required this.title, required this.links});

  final String title;
  final List<(String, VoidCallback)> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterTitle(title),
        const SizedBox(height: 18),
        for (final link in links) _FooterLink(label: link.$1, onTap: link.$2),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.white.withValues(alpha: 0.075)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.arrow_forward_rounded,
                color: _hovered ? AppColors.red : const Color(0xFFBFD0DC),
                size: 16,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: _hovered ? AppColors.white : const Color(0xFFC7D5E0),
                    fontSize: 15,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConnectColumn extends StatelessWidget {
  const _ConnectColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterTitle('Connect'),
        const SizedBox(height: 18),
        _ContactLink(
          icon: Icons.mail_rounded,
          label: AppConstants.email,
          onTap: () => sendEmail(AppConstants.email),
        ),
        const SizedBox(height: 10),
        _ContactLink(
          icon: Icons.phone_rounded,
          label: AppConstants.mobilePhone,
          onTap: () => callPhone(AppConstants.mobilePhone),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            _SocialButton(
              label: 'f',
              onTap: () => openLink(AppConstants.facebookUrl),
            ),
            const SizedBox(width: 9),
            _SocialButton(
              label: 'ig',
              onTap: () => openLink(AppConstants.instagramUrl),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactLink extends StatefulWidget {
  const _ContactLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.09 : 0.045),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: _hovered ? 0.16 : 0.08),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFC74446), AppColors.redDark],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.red.withValues(alpha: 0.24),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(widget.icon, color: AppColors.white, size: 18),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Color(0xFFD5E1EC),
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterTitle extends StatelessWidget {
  const _FooterTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFFFFA4A6),
        fontSize: 18,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.55,
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _HoverLift(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.07),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverLift extends StatefulWidget {
  const _HoverLift({required this.child});

  final Widget child;

  @override
  State<_HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<_HoverLift> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        child: widget.child,
      ),
    );
  }
}
