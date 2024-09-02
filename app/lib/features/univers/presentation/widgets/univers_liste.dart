import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/presentation/blocs/accueil_univers_bloc.dart';
import 'package:app/features/univers/presentation/pages/univers_page.dart';
import 'package:app/features/univers/presentation/widgets/univers_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/badge.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              .map((final e) => _UniversCarte(univers: e))
              .separator(const SizedBox(width: DsfrSpacings.s2w))
              .toList(),
        ),
      ),
    );
  }
}

class _UniversCarte extends StatelessWidget {
  const _UniversCarte({required this.univers});

  final TuileUnivers univers;

  @override
  Widget build(final BuildContext context) {
    const width = 140.0;

    return UniversCard(
      badge: univers.estTerminee
          ? const FnvBadge(
              label: Localisation.termine,
              backgroundColor: DsfrColors.success425,
            )
          : null,
      onTap: univers.estVerrouille
          ? null
          : () async =>
              GoRouter.of(context).pushNamed(UniversPage.name, extra: univers),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Image(
              imageUrl: univers.imageUrl,
              estVerrouille: univers.estVerrouille,
              width: width,
              borderRadius:
                  const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            Text(univers.titre, style: const DsfrTextStyle.bodyLgMedium()),
          ],
        ),
      ),
    );
  }
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
