import 'package:flutter/material.dart';
import 'package:simple_mortgage/features/chatbot/mortgage_chatbot.dart';
import 'package:simple_mortgage/features/home/widgets/contact_section.dart';
import 'package:simple_mortgage/features/home/widgets/footer_section.dart';
import 'package:simple_mortgage/features/home/widgets/hero_section.dart';
import 'package:simple_mortgage/features/home/widgets/mortgage_calculator_section.dart';
import 'package:simple_mortgage/features/home/widgets/quick_quote_section.dart';
import 'package:simple_mortgage/features/home/widgets/services_section.dart';
import 'package:simple_mortgage/features/home/widgets/testimonials_section.dart';
import 'package:simple_mortgage/features/home/widgets/trust_bar.dart';
import 'package:simple_mortgage/features/home/widgets/why_choose_us_section.dart';
import 'package:simple_mortgage/features/shared/app_navbar.dart';
import 'package:simple_mortgage/features/shared/mobile_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _homeKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _calculatorKey = GlobalKey();
  final _reviewsKey = GlobalKey();
  final _quoteKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  List<NavItem> get _items => [
    NavItem('Home', () => _scrollTo(_homeKey)),
    NavItem('Services', () => _scrollTo(_servicesKey)),
    NavItem('Calculator', () => _scrollTo(_calculatorKey)),
    NavItem('Reviews', () => _scrollTo(_reviewsKey)),
    NavItem('Team', () => Navigator.pushNamed(context, '/team')),
    NavItem('Contact', () => _scrollTo(_contactKey)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MobileDrawer(items: _items, onQuote: () => _scrollTo(_quoteKey)),
      body: Stack(
        children: [
          Column(
            children: [
              AppNavbar(
                items: _items,
                onQuote: () => _scrollTo(_quoteKey),
                onMenu: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              Expanded(
                child: SelectionArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Semantics(
                          container: true,
                          header: true,
                          child: HeroSection(
                            key: _homeKey,
                            onCalculator: () => _scrollTo(_calculatorKey),
                            onQuote: () => _scrollTo(_quoteKey),
                          ),
                        ),
                        const TrustBar(),
                        ServicesSection(
                          key: _servicesKey,
                          onTalkToOfficer: () => _scrollTo(_quoteKey),
                        ),
                        MortgageCalculatorSection(key: _calculatorKey),
                        const WhyChooseUsSection(),
                        TestimonialsSection(key: _reviewsKey),
                        QuickQuoteSection(key: _quoteKey),
                        ContactSection(key: _contactKey),
                        FooterSection(
                          onServices: () => _scrollTo(_servicesKey),
                          onCalculator: () => _scrollTo(_calculatorKey),
                          onReviews: () => _scrollTo(_reviewsKey),
                          onTeam: () => Navigator.pushNamed(context, '/team'),
                          onContact: () => _scrollTo(_contactKey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const MortgageChatbot(),
        ],
      ),
    );
  }
}
