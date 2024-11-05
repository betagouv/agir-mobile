import 'package:app/features/aides/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/aides/core/presentation/bloc/aides_accueil_event.dart';
import 'package:app/features/aides/core/presentation/bloc/aides_accueil_state.dart';
import 'package:app/features/aides/core/presentation/widgets/carte_aide.dart';
import 'package:app/features/aides/list/presentation/pages/aides_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MesAides extends StatelessWidget {
  const MesAides({super.key});

  @override
  Widget build(final context) {
    final bloc = context.read<AidesAccueilBloc>()
      ..add(const AidesAccueilRecuperationDemandee());

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const Text(Localisation.mesAides, style: DsfrTextStyle.headline5()),
        const SizedBox(height: DsfrSpacings.s3w),
        BlocBuilder<AidesAccueilBloc, AidesAccueilState>(
          builder: (final context, final state) {
            if (state.aides.isEmpty) {
              return const SizedBox();
            }
            final aides = state.aides;

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (final context, final index) {
                final aide = aides[index];

                return CarteAide(aide: aide);
              },
              separatorBuilder: (final context, final index) =>
                  const SizedBox(height: DsfrSpacings.s1w),
              itemCount: aides.length,
            );
          },
          bloc: bloc,
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Align(
          alignment: Alignment.centerLeft,
          child: DsfrLink.md(
            label: Localisation.mesAidesLien,
            onTap: () async => GoRouter.of(context).pushNamed(AidesPage.name),
          ),
        ),
      ],
    );
  }
}
