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
    required this.onContact,
    super.key,
  });

  final VoidCallback onServices;
  final VoidCallback onCalculator;
  final VoidCallback onReviews;
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
                      Expanded(flex: 2, child: columns[0]),
                      const SizedBox(width: 40),
                      for (var i = 1; i < columns.length; i++)
                        Expanded(child: columns[i]),
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
        const SizedBox(height: 12),
        for (final link in links)
          TextButton(
            onPressed: link.$2,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF9AAEBA),
              padding: const EdgeInsets.symmetric(vertical: 7),
            ),
            child: Text(link.$1),
          ),
      ],
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
        const SizedBox(height: 17),
        InkWell(
          onTap: () => sendEmail(AppConstants.email),
          child: const Text(
            AppConstants.email,
            style: TextStyle(color: Color(0xFF9AAEBA), fontSize: 13),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () => callPhone(AppConstants.mobilePhone),
          child: const Text(
            AppConstants.mobilePhone,
            style: TextStyle(color: Color(0xFF9AAEBA), fontSize: 13),
          ),
        ),
        const SizedBox(height: 18),
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

class _FooterTitle extends StatelessWidget {
  const _FooterTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: AppColors.red,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF355168)),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
