import 'package:app/features/authentification/questions/presentation/pages/question_themes_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgirEstEncoreEnExperimentationPage extends StatelessWidget {
  const AgirEstEncoreEnExperimentationPage({super.key, required this.commune});

  static const name = 'agir-est-encore-en-experimentation';
  static const path = '$name/:commune';

  final String commune;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            AgirEstEncoreEnExperimentationPage(
          commune: state.pathParameters['commune']!,
        ),
      );

  @override
  Widget build(final BuildContext context) {
    const bodyLg = DsfrTextStyle.bodyLg(lineHeight: 28);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              AssetsImages.illustration3,
              width: 208,
              height: 141,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(
            Localisation.agirEstEncoreEnExperimentation,
            style: DsfrTextStyle.headline2(),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          Text.rich(
            TextSpan(
              text: Localisation.agirEstEncoreEnExperimentationDetails,
              children: [
                TextSpan(
                  text: Localisation.communeEtSaRegion(commune),
                  style: bodyLg.copyWith(
                    color: DsfrColors.blueFranceSun113,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: Localisation.agirEstEncoreEnExperimentationDetails2,
                ),
              ],
            ),
            style: bodyLg,
          ),
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton(
          label: Localisation.jaiCompris,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () async =>
              GoRouter.of(context).pushNamed(QuestionThemesPage.name),
        ),
      ),
    );
  }
}
