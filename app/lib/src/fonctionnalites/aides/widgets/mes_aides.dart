import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_bloc.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesAides extends StatelessWidget {
  const MesAides({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => AidesBloc(
          aidesRepository: context.read<AidesRepository>(),
        )..add(const AidesRecuperationDemandee()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(Localisation.mesAides, style: DsfrFonts.headline4),
              const SizedBox(height: DsfrSpacings.s3w),
              BlocBuilder<AidesBloc, AidesState>(
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
                      return _CarteAide(titre: aide);
                    },
                    separatorBuilder: (final context, final index) =>
                        const SizedBox(height: DsfrSpacings.s1w),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class _CarteAide extends StatelessWidget {
  const _CarteAide({required this.titre});

  final String titre;

  @override
  Widget build(final BuildContext context) => Card(
        color: FnvColors.fondDeCarte,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DsfrSpacings.s2w,
            vertical: DsfrSpacings.s1w,
          ),
          child: Row(
            children: [
              Expanded(child: Text(titre, style: DsfrFonts.bodyMdMedium)),
              const Icon(DsfrIcons.systemArrowRightSLine),
            ],
          ),
        ),
      );
}
