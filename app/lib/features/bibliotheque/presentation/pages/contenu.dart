import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Contenu extends StatefulWidget {
  const Contenu({super.key, required this.contenu});

  final Recommandation contenu;

  @override
  State<Contenu> createState() => _ContenuState();
}

class _ContenuState extends State<Contenu> with MaterialStateMixin<Contenu> {
  @override
  Widget build(final context) {
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));
    final sousTitre = widget.contenu.sousTitre;

    return DsfrFocusWidget(
      isFocused: isFocused,
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shadows: recommandationOmbre,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Material(
          color: FnvColors.transparent,
          child: InkWell(
            onTap:
                () async => GoRouter.of(context).pushNamed(
                  ArticlePage.name,
                  pathParameters: {
                    'titre': widget.contenu.titre,
                    'id': widget.contenu.id,
                  },
                ),
            onHighlightChanged: updateMaterialState(WidgetState.pressed),
            onHover: updateMaterialState(WidgetState.hovered),
            focusColor: FnvColors.transparent,
            borderRadius: borderRadius,
            onFocusChange: updateMaterialState(WidgetState.focused),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: borderRadius.copyWith(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  child: FnvImage.network(
                    widget.contenu.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(DsfrSpacings.s2w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.contenu.thematique.displayName,
                        style: const DsfrTextStyle.bodyXsBold(),
                      ),
                      const SizedBox(height: DsfrSpacings.s1w),
                      Text(
                        widget.contenu.titre,
                        style: const DsfrTextStyle.headline4(
                          color: DsfrColors.blueFranceSun113,
                        ),
                      ),
                      if (sousTitre != null) ...[
                        const SizedBox(height: DsfrSpacings.s2w),
                        Text(sousTitre, style: const DsfrTextStyle.bodyMd()),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
