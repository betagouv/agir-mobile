import 'package:app/src/assets/images.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:app/src/pages/authentification/se_connecter_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class PreOnboardingCarrouselPage extends StatefulWidget {
  const PreOnboardingCarrouselPage({super.key});

  static const name = 'pre-onboarding-carrousel';
  static const path = '/$name';
  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) =>
            const PreOnboardingCarrouselPage(),
      );

  @override
  State<PreOnboardingCarrouselPage> createState() =>
      _PreOnboardingCarrouselPageState();
}

class _PreOnboardingCarrouselPageState extends State<PreOnboardingCarrouselPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                Polaroid(
                  image: Image.asset(AssetsImages.preOnboarding1),
                  titre: Localisation.preOnboarding1,
                ),
                Polaroid(
                  image: Image.asset(AssetsImages.preOnboarding2),
                  titre: Localisation.preOnboarding2,
                ),
                Polaroid(
                  image: Image.asset(AssetsImages.preOnboarding3),
                  titre: Localisation.preOnboarding3,
                ),
                ColoredBox(
                  color: const Color(0xFFF1ECFB),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DsfrSpacings.s3w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: DsfrSpacings.s8w),
                          const Icon(
                            DsfrIcons.businessBarChartBoxFill,
                            color: DsfrColors.blueFranceSun113,
                            size: 56,
                          ),
                          const SizedBox(height: DsfrSpacings.s3w),
                          const Text(
                            Localisation.preOnboardingFinTitre,
                            style: DsfrFonts.headline4,
                          ),
                          const SizedBox(height: DsfrSpacings.s1w),
                          const Text(
                            Localisation.preOnboardingFinSousTitre,
                            style: DsfrFonts.bodyMd,
                          ),
                          const Spacer(),
                          DsfrButton.lg(
                            label: Localisation.suivant,
                            onTap: () {},
                          ),
                          const SizedBox(height: DsfrSpacings.s3w),
                          Center(
                            child: DsfrLink.md(
                              label: Localisation.jaiDejaUnCompte,
                              onTap: () async {
                                await context.pushNamed(SeConnecterPage.name);
                              },
                            ),
                          ),
                          const SizedBox(height: DsfrSpacings.s7w),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: DsfrSpacings.s3w),
                child: TabPageSelector(
                  controller: _tabController,
                  indicatorSize: 8,
                  borderStyle: BorderStyle.none,
                  selectedColor: DsfrColors.blueFrance113,
                  color: DsfrColors.blueFrance975Hover,
                ),
              ),
            ),
          ],
        ),
      );
}

class Polaroid extends StatelessWidget {
  const Polaroid({
    required this.image,
    required this.titre,
    super.key,
  });

  final Widget image;
  final String titre;

  @override
  Widget build(final BuildContext context) {
    const p = DsfrFonts.bodyXlMedium;
    final strong = p.copyWith(fontWeight: FontWeight.w800);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s3w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            const SizedBox(height: DsfrSpacings.s7w),
            MarkdownBody(
              data: titre,
              styleSheet: MarkdownStyleSheet(
                p: p,
                strong: strong,
                textAlign: WrapAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
