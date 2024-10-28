import 'package:app/core/helpers/regex.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/presentation/widgets/tag_simulateur.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final Aid aide,
  ) async {
    if (aide.estSimulateurVelo) {
      await GoRouter.of(context).pushNamed(AideSimulateurVeloPage.name);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final aide = context.watch<AideBloc>().state.aide;

    return Scaffold(
      appBar: FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Text(
            aide.thematique,
            style: const DsfrTextStyle.bodySmMedium(),
            semanticsLabel: removeEmoji(aide.thematique),
          ),
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
          FnvHtmlWidget(aide.contenu),
          const SizedBox(height: DsfrSpacings.s6w),
        ],
      ),
      bottomNavigationBar: aide.aUnSimulateur
          ? FnvBottomBar(
              child: DsfrButton(
                label: Localisation.accederAuSimulateur,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () async =>
                    _handleAccederAuSimulateur(context, aide),
              ),
            )
          : null,
      backgroundColor: FnvColors.aidesFond,
    );
  }
}
