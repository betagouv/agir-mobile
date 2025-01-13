import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesRecommandations extends StatelessWidget {
  const MesRecommandations({super.key, required this.theme});

  final ThemeType theme;

  @override
  Widget build(final context) {
    context
        .read<RecommandationsBloc>()
        .add(RecommandationsRecuperationDemandee(theme));

    return const _View();
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Localisation.recommandationsTitre,
                style: DsfrTextStyle.headline4(),
              ),
              SizedBox(height: DsfrSpacings.s1v5),
              Text(
                Localisation.themeRecommandationsSousTitre,
                style: DsfrTextStyle.bodyMd(),
              ),
            ],
          ),
          SizedBox(height: DsfrSpacings.s2w),
          _List(),
        ],
      );
}

class _List extends StatelessWidget {
  const _List();

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
                  themeTag: ThemeTypeTag(themeType: e.thematique),
                  titre: e.titre,
                  onPop: () {
                    context
                        .read<RecommandationsBloc>()
                        .add(RecommandationsRecuperationDemandee(e.thematique));
                  },
                ),
              )
              .separator(const SizedBox(width: DsfrSpacings.s2w))
              .toList(),
        ),
      ),
    );
  }
}
