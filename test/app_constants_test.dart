import 'package:flutter_test/flutter_test.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';

void main() {
  test('whatsapp handoff uses the public mortgage contact number', () {
    expect(AppConstants.whatsappPhone, '+12022972024');
    expect(
      AppConstants.whatsappUrl,
      'https://wa.me/12022972024?text=Hi%20Simple%20Mortgage%20LLC%2C%20I%20have%20a%20mortgage%20question.',
    );
  });

  test('google maps embed uses the Fairfax office address', () {
    expect(AppConstants.googleMapsEmbedUrl, contains('google.com/maps'));
    expect(AppConstants.googleMapsEmbedUrl, contains('10304%20Eaton%20Place'));
    expect(AppConstants.googleMapsEmbedUrl, contains('output=embed'));
  });
}
