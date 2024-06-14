import 'package:app/features/aides/presentation/blocs/aides_accueil/aides_accueil_bloc.dart';
import 'package:app/features/aides/presentation/blocs/aides_accueil/aides_accueil_event.dart';
import 'package:app/features/aides/presentation/blocs/aides_accueil/aides_accueil_state.dart';
import 'package:app/features/aides/presentation/pages/aides_page.dart';
import 'package:app/features/aides/presentation/widgets/carte_aide.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MesAides extends StatelessWidget {
  const MesAides({super.key});

  @override
  Widget build(final BuildContext context) {
    final bloc = AidesAccueilBloc(aidesRepository: context.read())
      ..add(const AidesAccueilRecuperationDemandee());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Localisation.accueilMesAides,
            style: DsfrFonts.headline4,
          ),
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
          DsfrLink.md(
            label: Localisation.accueilMesAidesLien,
            onTap: () async => GoRouter.of(context).pushNamed(AidesPage.name),
          ),
        ],
      ),
    );
  }
}
