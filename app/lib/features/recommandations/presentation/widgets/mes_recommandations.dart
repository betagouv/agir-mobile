import 'package:app/features/recommandations/presentation/blocs/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/blocs/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/widgets/les_recommandations.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesRecommandations extends StatelessWidget {
  const MesRecommandations({super.key});

  @override
  Widget build(final BuildContext context) {
    context
        .read<RecommandationsBloc>()
        .add(const RecommandationsRecuperationDemandee());

    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Localisation.accueilRecommandationsTitre,
                style: DsfrTextStyle.headline5(),
              ),
              Text(
                Localisation.accueilRecommandationsSousTitre,
                style: DsfrTextStyle.bodyMd(),
              ),
            ],
          ),
        ),
        SizedBox(height: DsfrSpacings.s2w),
        LesRecommandations(),
      ],
    );
  }
}
