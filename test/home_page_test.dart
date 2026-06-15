import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_mortgage/app.dart';

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
}
