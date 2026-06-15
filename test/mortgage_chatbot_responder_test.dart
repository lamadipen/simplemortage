import 'package:flutter_test/flutter_test.dart';
import 'package:simple_mortgage/features/chatbot/mortgage_chatbot_responder.dart';

void main() {
  const responder = MortgageChatbotResponder();

  test('answers FHA questions', () {
    final answer = responder.answer('What is an FHA loan?');

    expect(answer, contains('FHA loan'));
    expect(answer, contains('government-backed'));
  });

  test('answers payment questions with estimate language', () {
    final answer = responder.answer('What is included in monthly payment?');

    expect(answer, contains('principal and interest'));
    expect(answer, contains('estimate'));
  });

  test('falls back for unsupported questions', () {
    final answer = responder.answer('Can you help me with something random?');

    expect(answer, contains('basic questions'));
    expect(answer, contains('loan officer'));
  });
}
