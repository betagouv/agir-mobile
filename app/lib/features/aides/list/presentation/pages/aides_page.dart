import 'package:app/core/helpers/regex.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aides/core/presentation/widgets/assitance_card.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_bloc.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_event.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_state.dart';
import 'package:app/features/aides/list/presentation/bloc/aides_disclaimer/aides_disclaimer_cubit.dart';
import 'package:app/features/aides/list/presentation/bloc/aides_disclaimer/aides_disclaimer_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidesPage extends StatelessWidget {
  const AidesPage({super.key});

  static const name = 'aides';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AidesPage(),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => AidesBloc(aidesPort: context.read())
          ..add(const AidesRecuperationDemandee()),
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => RootPage(
        body: BlocBuilder<AidesBloc, AidesState>(
          builder: (final context, final state) {
            final aides = state.aides;

            return ListView(
              children: [
                if (!state.isCovered)
                  BlocBuilder<AidesDisclaimerCubit, AidesDisclaimerState>(
                    builder: (final context, final state) => switch (state) {
                      AidesDisclaimerVisible() => DsfrNotice(
                          titre:
                              Localisation.leServiveNeCouvrePasEncoreVotreVille,
                          description: Localisation
                              .leServiveNeCouvrePasEncoreVotreVilleDescription,
                          onClose: () => context
                              .read<AidesDisclaimerCubit>()
                              .closeDisclaimer(),
                        ),
                      AidesDisclaimerNotVisible() => const SizedBox(),
                    },
                  ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(paddingVerticalPage),
                  children: [
                    const FnvTitle(
                      title: Localisation.mesAidesDisponibles,
                      subtitle: Localisation.mesAidesSousTitre,
                    ),
                    _Aides(aides: aides),
                  ],
                ),
                const SafeArea(child: SizedBox()),
              ],
            );
          },
        ),
      );
}

class _Aides extends StatelessWidget {
  const _Aides({required this.aides});

  final List<AidesModel> aides;

  @override
  Widget build(final context) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (final context, final index) => switch (aides[index]) {
          final AideThematiqueModel a => Padding(
              padding: const EdgeInsets.only(
                top: DsfrSpacings.s4w,
                bottom: DsfrSpacings.s2w,
              ),
              child: Text(
                a.thematique,
                style: const DsfrTextStyle.headline4(),
                semanticsLabel: removeEmoji(a.thematique),
              ),
            ),
          final AideModel a => AssitanceCard(assistance: a.value),
        },
        separatorBuilder: (final context, final index) =>
            const SizedBox(height: DsfrSpacings.s1w),
        itemCount: aides.length,
      );
}
