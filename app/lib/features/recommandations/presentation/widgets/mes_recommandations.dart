import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/widgets/les_recommandations.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
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
  Widget build(final context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Localisation.recommandationsTitre,
                style: DsfrTextStyle.headline4(),
              ),
              SizedBox(height: DsfrSpacings.s1v5),
              Text(
                Localisation.accueilRecommandationsSousTitre,
                style: DsfrTextStyle.bodyMd(),
              ),
            ],
          ),
          SizedBox(height: DsfrSpacings.s2w),
          LesRecommandations(),
        ],
      );
}
