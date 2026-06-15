import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';
import 'package:simple_mortgage/core/theme/app_colors.dart';
import 'package:simple_mortgage/core/theme/app_text_styles.dart';
import 'package:simple_mortgage/features/home/widgets/footer_section.dart';
import 'package:simple_mortgage/features/shared/app_navbar.dart';
import 'package:simple_mortgage/features/shared/link_utils.dart';
import 'package:simple_mortgage/features/shared/mobile_drawer.dart';
import 'package:simple_mortgage/features/shared/primary_button.dart';
import 'package:simple_mortgage/features/shared/section_container.dart';
import 'package:simple_mortgage/features/team/team_member.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _teamKey = GlobalKey();

  void _goHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  List<NavItem> get _items => [
    NavItem('Home', _goHome),
    NavItem('Services', _goHome),
    NavItem('Calculator', _goHome),
    NavItem('Reviews', _goHome),
    NavItem('Team', () {}),
    NavItem('Contact', _goHome),
  ];

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Our Team | Simple Mortgage LLC',
      color: AppColors.navy,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MobileDrawer(items: _items, onQuote: _goHome),
        body: Column(
          children: [
            AppNavbar(
              items: _items,
              onQuote: _goHome,
              onMenu: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            Expanded(
              child: SelectionArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const _TeamHero(),
                      _TeamGrid(key: _teamKey),
                      const _TeamCta(),
                      FooterSection(
                        onServices: _goHome,
                        onCalculator: _goHome,
                        onReviews: _goHome,
                        onTeam: () {},
                        onContact: _goHome,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamHero extends StatelessWidget {
  const _TeamHero();

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 700;
    return SectionContainer(
      backgroundColor: AppColors.blueLight,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
        vertical: mobile ? 68 : 92,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.redLight,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'PEOPLE BEHIND THE PROCESS',
              style: TextStyle(
                color: AppColors.red,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Mortgage guidance starts with people you can trust',
            textAlign: TextAlign.center,
            style: AppTextStyles.display.copyWith(
              fontSize: mobile ? 42 : 58,
              height: 1.02,
            ),
          ),
          const SizedBox(height: 22),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              'Our experienced loan officers, processors, and operations team '
              'work together to keep every step simple, prompt, and transparent.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(fontSize: mobile ? 18 : 19),
            ),
          ),
          const SizedBox(height: 32),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              _TeamProof(
                icon: Icons.groups_2_outlined,
                label: '12 professionals',
              ),
              _TeamProof(
                icon: Icons.location_on_outlined,
                label: 'Local expertise',
              ),
              _TeamProof(
                icon: Icons.handshake_outlined,
                label: 'One coordinated team',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamProof extends StatelessWidget {
  const _TeamProof({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.blue, size: 19),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.navyDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamGrid extends StatelessWidget {
  const _TeamGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = width < 620
        ? width - 40
        : width < 1000
        ? (width - 88) / 2
        : 376.0;

    return SectionContainer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'Meet the team',
            title: 'Expertise at every step',
            description:
                'From choosing a loan through processing and closing, our team '
                'brings specialized knowledge and shared accountability.',
          ),
          const SizedBox(height: 46),
          Wrap(
            spacing: 20,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              for (final member in teamMembers)
                SizedBox(
                  width: cardWidth,
                  child: _TeamCard(member: member),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatefulWidget {
  const _TeamCard({required this.member});

  final TeamMember member;

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: hovered ? AppColors.blue : AppColors.line),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.09),
                    blurRadius: 26,
                    offset: const Offset(0, 13),
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    member.imagePath,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    filterQuality: FilterQuality.medium,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x5C173A61)],
                        stops: [0.68, 1],
                      ),
                    ),
                  ),
                  if (member.leadership)
                    Positioned(
                      left: 18,
                      top: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          'LEADERSHIP',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 7),
                  Text(
                    member.role,
                    style: const TextStyle(
                      color: AppColors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                  if (member.nmls != null || member.licensedStates != null) ...[
                    const SizedBox(height: 13),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (member.nmls case final nmls?)
                          _CredentialChip(label: nmls),
                        if (member.licensedStates case final states?)
                          _CredentialChip(label: states),
                      ],
                    ),
                  ],
                  const SizedBox(height: 17),
                  Text(
                    member.bio,
                    style: AppTextStyles.body.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CredentialChip extends StatelessWidget {
  const _CredentialChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.blue,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TeamCta extends StatelessWidget {
  const _TeamCta();

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 700;
    return SectionContainer(
      backgroundColor: AppColors.blueLight,
      child: Container(
        padding: EdgeInsets.all(mobile ? 28 : 48),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(26),
        ),
        child: mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ctaCopy(),
                  const SizedBox(height: 26),
                  _ctaActions(),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _ctaCopy()),
                  const SizedBox(width: 40),
                  _ctaActions(),
                ],
              ),
      ),
    );
  }

  Widget _ctaCopy() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'READY TO TALK?',
          style: TextStyle(
            color: Color(0xFFE98B8D),
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Connect with a mortgage professional',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Get straightforward answers about your home financing options.',
          style: TextStyle(color: Color(0xFFB8CBD8), fontSize: 16, height: 1.5),
        ),
      ],
    );
  }

  Widget _ctaActions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        PrimaryButton(
          label: 'Call Our Team',
          icon: Icons.call_outlined,
          onPressed: () => callPhone(AppConstants.mobilePhone),
        ),
        PrimaryButton(
          label: 'Send an Email',
          icon: Icons.email_outlined,
          style: ButtonStyleType.light,
          onPressed: () => sendEmail(AppConstants.email),
        ),
      ],
    );
  }
}
