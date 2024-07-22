import 'package:app/features/univers/presentation/blocs/accueil_univers_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversListe extends StatelessWidget {
  const UniversListe({super.key});

  @override
  Widget build(final BuildContext context) {
    final univers = context.watch<AccueilUniversBloc>().state.univers;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
      clipBehavior: Clip.none,
      child: IntrinsicHeight(
        child: Row(
          children: univers
              .map(
                (final e) => _UniversCarte(
                  titre: e.titre,
                  imageUrl: e.imageUrl,
                  estVerrouille: e.estVerrouille,
                  estTermine: e.estTerminee,
                ),
              )
              .separator(const SizedBox(width: DsfrSpacings.s2w))
              .toList(),
        ),
      ),
    );
  }
}

class _UniversCarte extends StatelessWidget {
  const _UniversCarte({
    required this.titre,
    required this.imageUrl,
    required this.estVerrouille,
    required this.estTermine,
  });

  final String titre;
  final String imageUrl;
  final bool estVerrouille;
  final bool estTermine;

  @override
  Widget build(final BuildContext context) {
    const width = 140.0;

    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 13),
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
                    _Image(
                      imageUrl: imageUrl,
                      estVerrouille: estVerrouille,
                      width: width,
                      borderRadius: borderRadius,
                    ),
                    const SizedBox(height: DsfrSpacings.s1w),
                    Text(titre, style: const DsfrTextStyle.bodyLgMedium()),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (estTermine) const _Badge(),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();

  @override
  Widget build(final BuildContext context) => const DecoratedBox(
        decoration: ShapeDecoration(
          color: DsfrColors.success425,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s0v5)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
          child: Text(
            Localisation.termine,
            style: DsfrTextStyle.bodySmBold(color: Colors.white),
          ),
        ),
      );
}

class _Image extends StatelessWidget {
  const _Image({
    required this.imageUrl,
    required this.estVerrouille,
    required this.width,
    required this.borderRadius,
  });

  final String imageUrl;
  final bool estVerrouille;
  final double width;
  final BorderRadius borderRadius;

  @override
  Widget build(final BuildContext context) {
    final height = width * 1.08;

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl,
            width: width,
            height: height,
            color: estVerrouille ? Colors.grey : null,
            colorBlendMode: BlendMode.saturation,
            fit: BoxFit.cover,
            cacheHeight: height.toInt(),
          ),
          if (estVerrouille)
            const DecoratedBox(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: Padding(
                padding: EdgeInsets.all(DsfrSpacings.s1w),
                child: Icon(
                  DsfrIcons.systemLockFill,
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
