import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_mortgage/app.dart';
import 'package:simple_mortgage/features/team/team_page.dart';

void main() {
  testWidgets('home page renders without desktop layout exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SimpleMortgageApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Simple Mortgage Solutions for Your Dream Home'),
      findsOne,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('home page renders without mobile layout exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SimpleMortgageApp());
    await tester.pumpAndSettle();

    expect(find.text('A process that respects your time'), findsOne);
    expect(find.text('Speed and Control'), findsOne);
    expect(tester.takeException(), isNull);
  });

  testWidgets('mortgage chatbot answers a basic loan question', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SimpleMortgageApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ask a question'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('chatbot-question-input')),
      'What is an FHA loan?',
    );
    await tester.tap(find.byTooltip('Send message'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('government-backed mortgage', skipOffstage: false),
      findsOne,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('mortgage chatbot shows free handoff actions', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SimpleMortgageApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ask a question'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('chatbot-whatsapp-button')), findsOne);
    expect(find.byKey(const Key('chatbot-call-button')), findsOne);
    expect(tester.takeException(), isNull);
  });

  testWidgets('team route renders the published roster', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: TeamPage()));
    await tester.pumpAndSettle();

    expect(find.text('Ganesh Baniya'), findsOne);
    expect(find.text('Dr. Arjun Banjade'), findsOne);
    expect(find.text('Durga Bhattarai'), findsOne);
    expect(tester.takeException(), isNull);
  });
}
