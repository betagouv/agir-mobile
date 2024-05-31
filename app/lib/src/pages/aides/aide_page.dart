import 'package:app/src/design_system/composants/app_bar.dart';
import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_bloc.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_state.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:go_router/go_router.dart';

class AidePage extends StatelessWidget {
  const AidePage({super.key});

  static const name = 'aide';
  static const path = '/$name';

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) => const AidePage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        backgroundColor: FnvColors.aidesFond,
        body: BlocBuilder<AideBloc, AideState>(
          builder: (final context, final state) {
            final aide = state.aide;
            return ListView(
              padding: const EdgeInsets.all(DsfrSpacings.s3w),
              children: [
                Text(
                  aide.thematique,
                  style: DsfrFonts.bodySmMedium,
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                Text(
                  aide.titre,
                  style: DsfrFonts.headline2,
                ),
                if (aide.montantMax != null) ...[
                  const SizedBox(height: DsfrSpacings.s1w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DsfrTag.sm(
                      label: Localisation.jusqua(aide.montantMax!),
                      foregroundColor: FnvColors.tagForeground,
                      backgroundColor: DsfrColors.purpleGlycine925Hover,
                    ),
                  ),
                ],
                const SizedBox(height: DsfrSpacings.s3w),
                HtmlWidget(
                  aide.contenu,
                  factoryBuilder: MyUrlLauncherFactory.new,
                  textStyle: const DsfrTextStyle.fontFamily(),
                ),
              ],
            );
          },
        ),
      );
}

class MyUrlLauncherFactory extends WidgetFactory with UrlLauncherFactory {}
