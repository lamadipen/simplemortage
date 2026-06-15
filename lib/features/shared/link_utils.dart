import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String value) async {
  final uri = Uri.parse(value);
  await launchUrl(uri, webOnlyWindowName: '_blank');
}

Future<void> callPhone(String phone) =>
    launchUrl(Uri.parse('tel:${phone.replaceAll(RegExp(r'[^0-9+]'), '')}'));

Future<void> sendEmail(String email) => launchUrl(Uri.parse('mailto:$email'));
