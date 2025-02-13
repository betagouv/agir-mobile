import 'package:url_launcher/url_launcher_string.dart';

abstract final class FnvUrlLauncher {
  static Future<bool> launch(final String urlString) async => launchUrlString(urlString.trim());
}
