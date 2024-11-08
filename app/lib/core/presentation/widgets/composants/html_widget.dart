import 'package:app/features/aides/list/presentation/pages/aides_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:go_router/go_router.dart';
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
  Widget build(final context) => SelectionArea(
        child: HtmlWidget(
          html,
          customStylesBuilder: _handlePDansLi,
          factoryBuilder: MyUrlLauncherFactory.new,
          onTapUrl: (final url) async {
            final uri = Uri.parse(url);

            if (uri.host == 'jagis.beta.gouv.fr') {
              switch (uri.path) {
                case '/vos-aides':
                case '/aides':
                  await GoRouter.of(context).pushNamed(AidesPage.name);

                  return true;
                case '/bilan-environnemental':
                  await GoRouter.of(context)
                      .pushNamed(EnvironmentalPerformanceSummaryPage.name);

                  return true;
                default:
                  return false;
              }
            }

            return false;
          },
        ),
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
