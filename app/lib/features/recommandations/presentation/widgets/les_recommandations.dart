import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
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
                  themeTag: ThemeTypeTag(themeType: e.thematique),
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
