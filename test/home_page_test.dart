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

    await tester.enterText(find.byType(TextField).last, 'What is an FHA loan?');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pumpAndSettle();

    expect(find.textContaining('government-backed mortgage'), findsOne);
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
