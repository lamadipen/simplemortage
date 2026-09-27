import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:simple_mortgage/features/home/widgets/quick_quote_section.dart';

const _request = QuoteRequest(
  firstName: 'Jo',
  lastName: 'Doe',
  email: 'jo@example.com',
  phone: '(703) 555-0100',
  homePrice: '450,000',
  downPayment: '45,000',
  loanAmount: '405,000',
  creditRange: '700-759',
  message: '',
);

void main() {
  test('posts the quote as plain-text JSON to the web app', () async {
    late http.Request sent;
    final service = AppsScriptQuoteSubmissionService(
      endpoint: 'https://script.google.com/macros/s/test/exec',
      client: MockClient((request) async {
        sent = request;
        return http.Response('{"ok":true}', 200);
      }),
    );

    await service.submit(_request);

    expect(sent.method, 'POST');
    expect(sent.headers['content-type'], startsWith('text/plain'));
    expect(jsonDecode(sent.body), {
      'firstName': 'Jo',
      'lastName': 'Doe',
      'email': 'jo@example.com',
      'phone': '(703) 555-0100',
      'homePrice': '450,000',
      'downPayment': '45,000',
      'loanAmount': '405,000',
      'creditRange': '700-759',
      'message': '',
      'consent': true,
    });
  });

  test('throws when the web app rejects the request', () async {
    final service = AppsScriptQuoteSubmissionService(
      endpoint: 'https://script.google.com/macros/s/test/exec',
      client: MockClient(
        (_) async => http.Response('{"ok":false,"error":"invalid_email"}', 200),
      ),
    );

    expect(service.submit(_request), throwsException);
  });

  test('throws when the web app URL is not configured', () async {
    final service = AppsScriptQuoteSubmissionService(endpoint: '');

    expect(service.submit(_request), throwsStateError);
  });
}
