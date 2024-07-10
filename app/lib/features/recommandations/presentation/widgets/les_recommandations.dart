import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
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

    return SizedBox(
      height: MediaQuery.textScalerOf(context).scale(222),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        itemBuilder: (final context, final index) {
          final element = recommandations[index];

          return RecommendationWidget(
            id: element.id,
            points: '${element.points}',
            imageUrl: element.imageUrl,
            tagLabel: switch (element.thematique) {
              Thematique.alimentation => Localisation.lesCategoriesAlimentation,
              Thematique.transport => Localisation.lesCategoriesTransport,
              Thematique.logement => Localisation.lesCategoriesLogement,
              Thematique.consommation => Localisation.lesCategoriesConsommation,
              Thematique.climat => Localisation.lesCategoriesClimat,
              Thematique.dechet => Localisation.lesCategoriesDechet,
              Thematique.loisir => Localisation.lesCategoriesLoisir,
            },
            titre: element.titre,
          );
        },
        separatorBuilder: (final context, final index) => const SizedBox(
          width: DsfrSpacings.s2w,
        ),
        itemCount: recommandations.length,
        clipBehavior: Clip.none,
      ),
    );
  }
}
