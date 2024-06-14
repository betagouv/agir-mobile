import 'package:app/features/authentification/presentation/widgets/jai_deja_un_compte.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_carrousel_page.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/assets/svgs.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PreOnboardingPage extends StatelessWidget {
  const PreOnboardingPage({super.key});

  static const name = 'pre-onboarding';
  static const path = '/$name';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const PreOnboardingPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s3w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: DsfrSpacings.s15w),
                const Text(
                  Localisation.preOnboardingTitre,
                  style: DsfrFonts.displayXs,
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetsSvgs.republiqueFrancaise,
                      height: 53,
                    ),
                    const SizedBox(width: DsfrSpacings.s3w),
                    Image.asset(AssetsImages.franceNationVerte, height: 35),
                    const SizedBox(width: DsfrSpacings.s3w),
                    SvgPicture.asset(AssetsSvgs.ademe, height: 43),
                  ],
                ),
                const Spacer(),
                DsfrButton.lg(
                  label: Localisation.commencer,
                  onTap: () async => GoRouter.of(context)
                      .pushNamed(PreOnboardingCarrouselPage.name),
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                const JaiDejaUnCompteWidget(),
                const SizedBox(height: DsfrSpacings.s3w),
                const Align(child: VersionLabel()),
              ],
            ),
          ),
        ),
      );
}
