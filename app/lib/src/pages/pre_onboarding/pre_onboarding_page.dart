import 'package:agir/src/assets/images.dart';
import 'package:agir/src/assets/svgs.dart';
import 'package:agir/src/l10n/l10n.dart';
import 'package:agir/src/pages/pre_onboarding/pre_onboarding_carrousel_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PreOnboardingPage extends StatelessWidget {
  const PreOnboardingPage({super.key});

  static const name = 'pre-onboarding';
  static const path = '/$name';

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) => const PreOnboardingPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: DsfrSpacings.s15w),
                const Text(
                  Localisation.preOnboardingTitre,
                  style: DsfrFonts.displayXs,
                ),
                const SizedBox(height: DsfrSpacings.s2w),
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
                  onTap: () async {
                    await context.pushNamed(PreOnboardingCarrouselPage.name);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
