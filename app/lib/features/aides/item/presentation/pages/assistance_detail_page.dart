import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aides/core/presentation/widgets/tag_simulateur.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AssistanceDetailPage extends StatelessWidget {
  const AssistanceDetailPage({super.key});

  static const name = 'aide';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AssistanceDetailPage(),
      );

  @override
  Widget build(final context) {
    final assistance = context.watch<AideBloc>().state.aide;

    return Scaffold(
      appBar: FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ThemeTypeTag(themeType: assistance.themeType),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          Text(assistance.titre, style: const DsfrTextStyle.headline2()),
          if (assistance.aUnSimulateur || assistance.montantMax != null) ...[
            const SizedBox(height: DsfrSpacings.s1w),
            Wrap(
              spacing: DsfrSpacings.s1w,
              children: [
                if (assistance.montantMax != null)
                  DsfrTag.sm(
                    label: TextSpan(
                      text: Localisation.jusqua +
                          Localisation.euro(assistance.montantMax!),
                    ),
                    backgroundColor: DsfrColors.purpleGlycine925Hover,
                    foregroundColor: const Color(0xFF432636),
                  ),
                if (assistance.aUnSimulateur) const TagSimulateur(),
              ],
            ),
          ],
          const SizedBox(height: DsfrSpacings.s3w),
          FnvHtmlWidget(assistance.contenu),
          const SizedBox(height: DsfrSpacings.s6w),
        ],
      ),
      bottomNavigationBar: assistance.aUnSimulateur
          ? FnvBottomBar(
              child: DsfrButton(
                label: Localisation.accederAuSimulateur,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () async {
                  if (assistance.estSimulateurVelo) {
                    await GoRouter.of(context)
                        .pushNamed(AideSimulateurVeloPage.name);
                  }
                },
              ),
            )
          : null,
      backgroundColor: FnvColors.aidesFond,
    );
  }
}
