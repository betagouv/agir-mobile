import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/presentation/blocs/aide/aide_bloc.dart';
import 'package:app/features/aides/presentation/widgets/tag_simulateur.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class AidePage extends StatelessWidget {
  const AidePage({super.key});

  static const name = 'aide';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AidePage(),
      );

  Future<void> _handleAccederAuSimulateur(
    final BuildContext context,
    final Aide aide,
  ) async {
    if (aide.estSimulateurVelo) {
      await GoRouter.of(context).pushNamed(AideSimulateurVeloPage.name);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final aide = context.watch<AideBloc>().state.aide;

    return Scaffold(
      appBar: const FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(DsfrSpacings.s3w),
        children: [
          Text(aide.thematique, style: const DsfrTextStyle.bodySmMedium()),
          const SizedBox(height: DsfrSpacings.s2w),
          Text(aide.titre, style: const DsfrTextStyle.headline2()),
          if (aide.aUnSimulateur || aide.montantMax != null) ...[
            const SizedBox(height: DsfrSpacings.s1w),
            Wrap(
              spacing: DsfrSpacings.s1w,
              children: [
                if (aide.montantMax != null)
                  DsfrTag.sm(
                    label: TextSpan(
                      text: Localisation.jusqua +
                          Localisation.euro(aide.montantMax!),
                    ),
                    backgroundColor: DsfrColors.purpleGlycine925Hover,
                    foregroundColor: FnvColors.tagForeground,
                  ),
                if (aide.aUnSimulateur) const TagSimulateur(),
              ],
            ),
          ],
          const SizedBox(height: DsfrSpacings.s3w),
          HtmlWidget(
            aide.contenu,
            factoryBuilder: MyUrlLauncherFactory.new,
            textStyle: const DsfrTextStyle(fontSize: 15, lineHeight: 24),
          ),
          const SizedBox(height: DsfrSpacings.s6w),
        ],
      ),
      bottomNavigationBar: aide.aUnSimulateur
          ? FnvBottomBar(
              child: DsfrButton(
                label: Localisation.accederAuSimulateur,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onTap: () async => _handleAccederAuSimulateur(context, aide),
              ),
            )
          : null,
      backgroundColor: FnvColors.aidesFond,
    );
  }
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
    } on PlatformException catch (error) {
      debugPrint('Could not launch "$url": $error');

      return false;
    }
  }
}
