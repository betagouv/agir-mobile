import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ToutEstPretPage extends StatelessWidget {
  const ToutEstPretPage({super.key});

  static const name = 'tout-est-pret';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const ToutEstPretPage(),
      );

  @override
  Widget build(final BuildContext context) {
    const blueFranceSun113 = DsfrColors.blueFranceSun113;

    const bodyLg = DsfrTextStyle.bodyLg(lineHeight: 28);
    const bodyLgBold = DsfrTextStyle.bodyLgBold();

    final arrow = TextSpan(
      text: '→ ',
      style: bodyLgBold.copyWith(color: blueFranceSun113),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueFranceSun113),
      ),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              AssetsImages.illustration5,
              width: 208,
              height: 141,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(
            Localisation.toutEstPret,
            style: DsfrTextStyle.headline2(),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          Text.rich(
            TextSpan(
              children: [
                arrow,
                const TextSpan(
                  text: 'Faites votre bilan personnel ',
                  style: bodyLgBold,
                ),
                const TextSpan(
                  text: 'et obtenez des recommandations personnalisées\n\n',
                ),
                arrow,
                const TextSpan(text: 'Explorez ', style: bodyLgBold),
                const TextSpan(
                  text:
                      'nos articles et les aides financières adaptées à votre situation\n\n',
                ),
                arrow,
                const TextSpan(text: 'Gagnez des ', style: bodyLgBold),
                const WidgetSpan(
                  child: Icon(
                    DsfrIcons.othersLeafFill,
                    size: DsfrSpacings.s2w,
                    color: Color(0xFF3CD277),
                  ),
                ),
                const TextSpan(
                  text: ' en améliorant votre coût environnemental',
                ),
              ],
            ),
            style: bodyLg,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton(
          label: Localisation.cestParti,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () async =>
              GoRouter.of(context).pushReplacementNamed(AccueilPage.name),
        ),
      ),
    );
  }
}
