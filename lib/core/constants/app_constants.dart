abstract final class AppConstants {
  static const companyName = 'Simple Mortgage LLC';
  static const email = 'info@smortgageloan.com';
  // Web app URL of apps_script/quote_requests.gs (Deploy > Manage deployments).
  static const quoteRequestWebAppUrl =
      'https://script.google.com/macros/s/AKfycbxvqXEwjapqWbLm_jYHefiJxTuo5JYZjd0_f3Iy1XS1flfSAfkGbbxGMUC6YRbZOqwO/exec';
  // reCAPTCHA v3 site key (public); also set in web/index.html. The secret key
  // lives only in the Apps Script's Script Properties as RECAPTCHA_SECRET.
  static const recaptchaSiteKey = '6LcegdItAAAAAP89yTgnQ1WlvzNVJVbpFJXfk8v1';
  static const mobilePhone = '202-297-2024';
  static const officePhone = '703-655-9533';
  static const whatsappPhone = '+12022972024';
  static const address = '10304 Eaton Place, Suite 100, Fairfax, VA 22030';
  static const applyUrl = 'https://prod.lendingpad.com/simple-mortgage-llc/pos';
  static const whatsappUrl =
      'https://wa.me/12022972024?text=Hi%20Simple%20Mortgage%20LLC%2C%20I%20have%20a%20mortgage%20question.';
  static const canonicalUrl = 'https://www.smortgageloan.com/';
  static const mapUrl =
      'https://www.google.com/maps/search/?api=1&query=10304+Eaton+Place+Suite+100+Fairfax+VA+22030';
  static const googleMapsEmbedUrl =
      'https://www.google.com/maps?q=10304%20Eaton%20Place%2C%20Suite%20100%2C%20Fairfax%2C%20VA%2022030&output=embed';
  static const nmlsUrl = 'https://www.nmlsconsumeraccess.org/';
  static const facebookUrl = 'https://www.facebook.com/SimpleMortgageFairFax';
  static const instagramUrl = 'https://www.instagram.com/simplemortgagellc';

  static const disclaimer =
      'For information purposes only. This is not a commitment to lend or '
      'extend credit. Information and/or dates are subject to change without '
      'notice. All loans are subject to credit approval.';

  static const licenses = <String>[
    'Company NMLS No: 1951072',
    'Licensed Virginia Broker Licence No: MC-7046',
    'Maryland Lender Licence No: 1951072',
    'North Carolina Mortgage Broker Licence No: B-217501',
    'Ohio Residential Mortgage Lending Act Certificate of Registration RM.805112.000',
    'Pennsylvania Broker License No. 107394',
  ];
}
