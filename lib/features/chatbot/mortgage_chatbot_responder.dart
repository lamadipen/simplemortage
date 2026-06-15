class MortgageChatbotResponder {
  const MortgageChatbotResponder();

  String answer(String question) {
    final normalized = question.toLowerCase().trim();
    if (normalized.isEmpty) {
      return 'Ask me a mortgage question like “What is an FHA loan?” or “How much down payment do I need?”';
    }

    if (_containsAny(normalized, ['fha'])) {
      return 'An FHA loan is a government-backed mortgage that may help buyers qualify with more flexible credit and down payment requirements. Simple Mortgage LLC can help you compare FHA with Conventional options.';
    }
    if (_containsAny(normalized, ['va loan', 'veteran', 'military', 'va '])) {
      return 'VA loans are designed for eligible service members, veterans, and surviving spouses. They may offer strong benefits such as no required down payment for qualified borrowers.';
    }
    if (_containsAny(normalized, ['conventional'])) {
      return 'A Conventional loan is not government-insured and is often a good fit for qualified buyers with stable income, credit, and down payment funds. It can work well for primary homes, second homes, and investment properties.';
    }
    if (_containsAny(normalized, ['down payment', 'downpayment'])) {
      return 'Down payment requirements depend on the loan type, credit profile, occupancy, and property. Some programs allow lower down payments, while putting more down can reduce the loan amount and possibly monthly costs.';
    }
    if (_containsAny(normalized, ['credit', 'score', 'fico'])) {
      return 'Credit score is one factor lenders review, along with income, debts, assets, and property details. Different programs have different guidelines, so a loan officer can help you understand realistic options.';
    }
    if (_containsAny(normalized, ['rate', 'interest'])) {
      return 'Mortgage rates can change daily and depend on factors like credit, loan type, down payment, loan amount, and market conditions. For an accurate quote, it is best to speak with Simple Mortgage LLC directly.';
    }
    if (_containsAny(normalized, ['payment', 'monthly', 'calculator'])) {
      return 'Your monthly payment usually includes principal and interest, plus taxes, insurance, and possibly PMI or HOA dues. You can use the calculator on this site for an estimate.';
    }
    if (_containsAny(normalized, ['pmi', 'mortgage insurance'])) {
      return 'PMI, or private mortgage insurance, may apply to some Conventional loans when the down payment is below certain levels. It helps protect the lender and is part of the monthly payment estimate.';
    }
    if (_containsAny(normalized, [
      'preapproval',
      'pre-approval',
      'pre approve',
    ])) {
      return 'A pre-approval helps estimate how much you may qualify for after reviewing your credit, income, assets, and debts. It is useful before shopping for a home.';
    }
    if (_containsAny(normalized, ['refinance', 'refi'])) {
      return 'Refinancing replaces your current mortgage with a new one. Homeowners often refinance to adjust the rate, term, monthly payment, or access equity, depending on qualification.';
    }
    if (_containsAny(normalized, ['closing cost', 'closing costs'])) {
      return 'Closing costs can include lender, title, recording, escrow, prepaid tax, and insurance items. The exact amount depends on the loan, property, and transaction details.';
    }
    if (_containsAny(normalized, ['document', 'documents', 'paperwork'])) {
      return 'Common mortgage documents include pay stubs, W-2s or tax returns, bank statements, photo ID, and purchase contract details. The exact list depends on your loan scenario.';
    }
    if (_containsAny(normalized, ['contact', 'phone', 'email', 'call'])) {
      return 'You can contact Simple Mortgage LLC at info@smortgageloan.com, call 202-297-2024, or use the Quick Quote form on this website.';
    }
    if (_containsAny(normalized, ['license', 'nmls'])) {
      return 'Simple Mortgage LLC is Company NMLS No. 1951072. Licensing details are listed in the footer of this website.';
    }

    return 'I can help with basic questions about Conventional, FHA, VA loans, down payments, credit, rates, payments, PMI, pre-approval, refinancing, and closing costs. For advice specific to your file, please contact a Simple Mortgage LLC loan officer.';
  }

  bool _containsAny(String text, List<String> terms) {
    return terms.any(text.contains);
  }
}
