import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LesRecommandations extends StatelessWidget {
  const LesRecommandations({super.key});

  @override
  Widget build(final context) {
    final recommandations =
        context.watch<RecommandationsBloc>().state.recommandations;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: IntrinsicHeight(
        child: Row(
          children: recommandations
              .map(
                (final e) => RecommendationWidget(
                  id: e.id,
                  type: e.type,
                  points: '${e.points}',
                  imageUrl: e.imageUrl,
                  tagLabel: switch (e.thematique) {
                    'alimentation' => Localisation.lesCategoriesAlimentation,
                    'transport' => Localisation.lesCategoriesTransport,
                    'logement' => Localisation.lesCategoriesLogement,
                    'consommation' => Localisation.lesCategoriesConsommation,
                    'climat' => Localisation.lesCategoriesClimat,
                    'dechet' => Localisation.lesCategoriesDechet,
                    'loisir' => Localisation.lesCategoriesLoisir,
                    // ignore: avoid-unnecessary-type-assertions
                    String() => throw UnimplementedError(),
                  },
                  titre: e.titre,
                ),
              )
              .separator(const SizedBox(width: DsfrSpacings.s2w))
              .toList(),
        ),
      ),
    );
  }
}
