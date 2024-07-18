import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Contenu extends StatelessWidget {
  const Contenu({required this.contenu, super.key});

  final Recommandation contenu;

  @override
  Widget build(final BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shadows: recommandationOmbre,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: borderRadius.copyWith(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
            child: Image.network(contenu.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  contenu.thematiqueLabel,
                  style: const DsfrTextStyle.bodyXsBold(),
                ),
                const SizedBox(height: DsfrSpacings.s1w),
                Text(
                  contenu.titre,
                  style: const DsfrTextStyle.headline4(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
                if (contenu.sousTitre != null) ...[
                  const SizedBox(height: DsfrSpacings.s2w),
                  Text(contenu.sousTitre!, style: const DsfrTextStyle.bodyMd()),
                ],
                const SizedBox(height: DsfrSpacings.s2w),
                Align(
                  alignment: Alignment.centerLeft,
                  child: DsfrLink.md(
                    label: 'Continuer la lecture',
                    icon: DsfrIcons.systemArrowRightLine,
                    iconPosition: DsfrLinkIconPosition.end,
                    onPressed: () async => GoRouter.of(context).pushNamed(
                      ArticlePage.name,
                      pathParameters: {'id': contenu.id},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
