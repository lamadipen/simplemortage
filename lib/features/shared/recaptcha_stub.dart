/// reCAPTCHA only runs in the browser; see recaptcha_web.dart.
Future<String> getRecaptchaToken(String siteKey, String action) =>
    throw UnsupportedError('reCAPTCHA is only available on the web');
