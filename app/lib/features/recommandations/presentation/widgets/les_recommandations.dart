import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/presentation/blocs/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LesRecommandations extends StatelessWidget {
  const LesRecommandations({super.key});

  @override
  Widget build(final BuildContext context) {
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
                    Thematique.alimentation =>
                      Localisation.lesCategoriesAlimentation,
                    Thematique.transport => Localisation.lesCategoriesTransport,
                    Thematique.logement => Localisation.lesCategoriesLogement,
                    Thematique.consommation =>
                      Localisation.lesCategoriesConsommation,
                    Thematique.climat => Localisation.lesCategoriesClimat,
                    Thematique.dechet => Localisation.lesCategoriesDechet,
                    Thematique.loisir => Localisation.lesCategoriesLoisir,
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
