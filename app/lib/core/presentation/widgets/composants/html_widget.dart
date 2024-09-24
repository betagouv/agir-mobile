import 'package:dsfr/dsfr.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class FnvHtmlWidget extends StatelessWidget {
  const FnvHtmlWidget(this.html, {super.key});

  final String html;

  /// Le CMS peut retourner des balises `<li>` avec des balises `<p>` dedans.
  /// Cela pose des problèmes de mise en forme, alors on retire les marges.
  Map<String, String>? _handlePDansLi(final dom.Element element) =>
      element.parent?.localName == 'li' && element.localName == 'p'
          ? {'margin': '0'}
          : null;

  @override
  Widget build(final BuildContext context) => HtmlWidget(
        html,
        customStylesBuilder: _handlePDansLi,
        factoryBuilder: MyUrlLauncherFactory.new,
        textStyle: const DsfrTextStyle(fontSize: 15),
      );
}

/// Besoin de faire notre propre implementation car les urls web retourne faux à l'appel de canLaunchUrl.
class MyUrlLauncherFactory extends WidgetFactory with UrlLauncherFactory {
  @override
  Future<bool> onTapUrl(final String url) async {
    final result = await super.onTapUrl(url);
    if (result) {
      return result;
    }

    try {
      return await launchUrl(Uri.parse(url));
    } on PlatformException {
      return false;
    }
  }
}
