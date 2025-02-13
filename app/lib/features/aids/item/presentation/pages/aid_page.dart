import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aids/core/presentation/widgets/partner_widget.dart';
import 'package:app/features/aids/core/presentation/widgets/simulator_tag.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_bloc.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidPage extends StatelessWidget {
  const AidPage({super.key});

  static const name = 'aide';
  static const path = name;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => const AidPage(),
  );

  @override
  Widget build(final context) {
    final aid = context.watch<AidBloc>().state.aid;

    return FnvScaffold(
      appBar: FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ThemeTypeTag(themeType: aid.themeType),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          Text(aid.title, style: const DsfrTextStyle.headline2()),
          if (aid.aUnSimulateur || aid.amountMax != null) ...[
            const SizedBox(height: DsfrSpacings.s1w),
            Wrap(
              spacing: DsfrSpacings.s1w,
              children: [
                if (aid.amountMax != null)
                  DsfrTag.sm(
                    label: TextSpan(
                      text:
                          Localisation.jusqua +
                          Localisation.euro(aid.amountMax!),
                    ),
                    backgroundColor: DsfrColors.purpleGlycine925Hover,
                    foregroundColor: const Color(0xFF432636),
                  ),
                if (aid.aUnSimulateur) const SimulatorTag(),
              ],
            ),
          ],
          if (aid.partner != null) ...[
            const SizedBox(height: DsfrSpacings.s3w),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xffeef2ff),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xffb1b1ff)),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(DsfrSpacings.s1v5),
                ),
              ),
              child: PartnerWidget(partner: aid.partner!),
            ),
          ],
          const SizedBox(height: DsfrSpacings.s4w),
          FnvHtmlWidget(aid.content),
          const SizedBox(height: DsfrSpacings.s6w),
        ],
      ),
      bottomNavigationBar:
          aid.aUnSimulateur
              ? FnvBottomBar(
                child: DsfrButton(
                  label: Localisation.accederAuSimulateur,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrButtonSize.lg,
                  onPressed: () async {
                    if (aid.estSimulateurVelo) {
                      await GoRouter.of(
                        context,
                      ).pushNamed(AideSimulateurVeloPage.name);
                    }
                  },
                ),
              )
              : null,
    );
  }
}
