import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecommendationWidget extends StatelessWidget {
  const RecommendationWidget({
    required this.id,
    required this.type,
    required this.points,
    required this.imageUrl,
    required this.tagLabel,
    required this.titre,
    super.key,
  });

  final String id;
  final TypeDuContenu type;
  final String points;
  final String imageUrl;
  final String tagLabel;
  final String titre;

  @override
  Widget build(final BuildContext context) {
    const width = 200.0;

    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return GestureDetector(
      onTap: () async => switch (type) {
        TypeDuContenu.article => GoRouter.of(context).pushNamed(
            ArticlePage.name,
            pathParameters: {'id': id},
          ),
        TypeDuContenu.kyc => GoRouter.of(context).pushNamed(
            MieuxVousConnaitreEditPage.name,
            pathParameters: {'id': id},
          ),
        TypeDuContenu.quiz => GoRouter.of(context).pushNamed(
            QuizPage.name,
            pathParameters: {'id': id},
          ),
      },
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shadows: recommandationOmbre,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: DsfrSpacings.s1w,
            top: DsfrSpacings.s1w,
            right: DsfrSpacings.s1w,
            bottom: DsfrSpacings.s3v,
          ),
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    _Image(
                      imageUrl: imageUrl,
                      width: width,
                      borderRadius: borderRadius,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: DsfrSpacings.s1v5,
                        top: DsfrSpacings.s1v5,
                        right: DsfrSpacings.s1v5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: _TypeTag(type: type)),
                          const SizedBox(width: DsfrSpacings.s1v),
                          _Points(
                            points: points,
                            borderRadius: borderRadius,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DsfrSpacings.s1v5),
                _Tag(tagLabel: tagLabel),
                const SizedBox(height: DsfrSpacings.s1w),
                Flexible(child: _Title(titre: titre)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeTag extends StatelessWidget {
  const _TypeTag({required this.type});

  final TypeDuContenu type;

  @override
  Widget build(final BuildContext context) => DsfrTag.sm(
        label: TextSpan(
          text: switch (type) {
            TypeDuContenu.article => Localisation.article,
            TypeDuContenu.kyc => Localisation.mieuxVousConnaitre,
            TypeDuContenu.quiz => Localisation.quiz,
          },
        ),
        backgroundColor: switch (type) {
          TypeDuContenu.article => DsfrColors.brownCaramel925,
          TypeDuContenu.kyc => DsfrColors.pinkTuile925,
          TypeDuContenu.quiz => DsfrColors.greenBourgeon950,
        },
        foregroundColor: DsfrColors.grey50,
        textStyle: const DsfrTextStyle.bodySm(),
      );
}

class _Title extends StatelessWidget {
  const _Title({required this.titre});

  final String titre;

  @override
  Widget build(final BuildContext context) =>
      Text(titre, style: const DsfrTextStyle.bodyMdMedium());
}

class _Tag extends StatelessWidget {
  const _Tag({required this.tagLabel});

  final String tagLabel;

  @override
  Widget build(final BuildContext context) => DsfrTag.sm(
        label: TextSpan(text: tagLabel),
        backgroundColor: FnvColors.accueilFond,
        foregroundColor: DsfrColors.grey50,
        textStyle: const DsfrTextStyle.bodySmBold(),
      );
}

class _Image extends StatelessWidget {
  const _Image({
    required this.imageUrl,
    required this.width,
    required this.borderRadius,
  });

  final String imageUrl;
  final double width;
  final BorderRadius borderRadius;

  @override
  Widget build(final BuildContext context) {
    final height = width * 0.6;

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        cacheWidth: width.toInt(),
        cacheHeight: height.toInt(),
      ),
    );
  }
}

class _Points extends StatelessWidget {
  const _Points({required this.points, required this.borderRadius});

  final String points;
  final BorderRadius borderRadius;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DsfrSpacings.s1v5,
            horizontal: DsfrSpacings.s1w,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(points, style: const DsfrTextStyle.bodySmBold()),
              const SizedBox(width: DsfrSpacings.s1v),
              const Icon(
                DsfrIcons.othersLeafFill,
                size: DsfrSpacings.s2w,
                color: Color(0xFF3CD277),
              ),
            ],
          ),
        ),
      );
}
