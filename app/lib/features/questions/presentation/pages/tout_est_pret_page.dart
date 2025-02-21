import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/questions/core/presentation/widgets/onboarding_illustration.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ToutEstPretPage extends StatelessWidget {
  const ToutEstPretPage({super.key});

  static const name = 'tout-est-pret';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const ToutEstPretPage());

  @override
  Widget build(final context) {
    const blueFranceSun113 = DsfrColors.blueFranceSun113;

    const bodyLg = DsfrTextStyle.bodyLg();
    const bodyLgBold = DsfrTextStyle.bodyLgBold();

    final arrow = TextSpan(text: '→ ', style: bodyLgBold.copyWith(color: blueFranceSun113));

    return FnvScaffold(
      appBar: AppBar(backgroundColor: FnvColors.homeBackground, iconTheme: const IconThemeData(color: blueFranceSun113)),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          const Align(alignment: Alignment.centerLeft, child: OnboardingIllustration(assetName: AssetImages.illustration5)),
          const Text(Localisation.toutEstPret, style: DsfrTextStyle.headline2()),
          const SizedBox(height: DsfrSpacings.s2w),
          Text.rich(
            TextSpan(
              children: [
                arrow,
                const TextSpan(text: 'Faites votre bilan personnel ', style: bodyLgBold),
                const TextSpan(text: 'et obtenez des recommandations personnalisées\n\n'),
                arrow,
                const TextSpan(text: 'Explorez ', style: bodyLgBold),
                const TextSpan(text: 'nos articles et les aides financières adaptées à votre situation\n\n'),
                arrow,
                const TextSpan(text: 'Gagnez des ', style: bodyLgBold),
                const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w, color: Color(0xFF3CD277)),
                ),
                const TextSpan(text: ' en améliorant votre coût environnemental'),
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
          onPressed: () => GoRouter.of(context).goNamed(HomePage.name),
        ),
      ),
    );
  }
}
