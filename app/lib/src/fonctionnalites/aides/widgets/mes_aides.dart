import 'package:app/src/fonctionnalites/aides/bloc/aides_accueil/aides_accueil_bloc.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_accueil/aides_accueil_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_accueil/aides_accueil_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:app/src/fonctionnalites/aides/widgets/carte_aide.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:app/src/pages/aides/aides_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MesAides extends StatelessWidget {
  const MesAides({super.key});

  @override
  Widget build(final BuildContext context) {
    final bloc = AidesAccueilBloc(
      aidesRepository: context.read<AidesRepository>(),
    )..add(const AidesAccueilRecuperationDemandee());
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
            bloc: bloc,
            builder: (final context, final state) {
              if (state.titres.isEmpty) {
                return const SizedBox();
              }
              final aides = state.titres;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: aides.length,
                itemBuilder: (final context, final index) {
                  final aide = aides[index];
                  return CarteAide(titre: aide);
                },
                separatorBuilder: (final context, final index) =>
                    const SizedBox(height: DsfrSpacings.s1w),
              );
            },
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrLink.md(
            label: Localisation.accueilMesAidesLien,
            onTap: () async => context.pushNamed(AidesPage.name),
          ),
        ],
      ),
    );
  }
}
