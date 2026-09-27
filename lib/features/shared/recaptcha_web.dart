import 'dart:async';
import 'dart:js_interop';

@JS('grecaptcha')
external _Grecaptcha? get _grecaptcha;

extension type _Grecaptcha._(JSObject _) implements JSObject {
  external void ready(JSFunction callback);
  external JSPromise<JSString> execute(String siteKey, _ExecuteOptions options);
}

extension type _ExecuteOptions._(JSObject _) implements JSObject {
  external factory _ExecuteOptions({String action});
}

/// Returns a single-use reCAPTCHA v3 token (valid for two minutes) from the
/// api.js script loaded in web/index.html.
Future<String> getRecaptchaToken(String siteKey, String action) async {
  final grecaptcha = _grecaptcha;
  if (grecaptcha == null) {
    throw StateError('reCAPTCHA script has not loaded');
  }
  final ready = Completer<void>();
  grecaptcha.ready((() => ready.complete()).toJS);
  await ready.future;
  final token = await grecaptcha
      .execute(siteKey, _ExecuteOptions(action: action))
      .toDart;
  return token.toDart;
}
