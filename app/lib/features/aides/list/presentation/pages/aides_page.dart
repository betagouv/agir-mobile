import 'package:app/core/helpers/regex.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aides/core/presentation/widgets/carte_aide.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_bloc.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_event.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_state.dart';
import 'package:app/features/aides/list/presentation/bloc/aides_disclaimer/aides_disclaimer_cubit.dart';
import 'package:app/features/aides/list/presentation/bloc/aides_disclaimer/aides_disclaimer_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_state.dart';
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
  Widget build(final BuildContext context) {
    final bloc = AidesBloc(aidesPort: context.read())
      ..add(const AidesRecuperationDemandee());
    context
        .read<UtilisateurBloc>()
        .add(const UtilisateurRecuperationDemandee());

    return RootPage(
      body: BlocBuilder<AidesBloc, AidesState>(
        builder: (final context, final state) {
          final aides = state.aides;

          return ListView(
            children: [
              const _Disclaimer(),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(paddingVerticalPage),
                children: [
                  const SizedBox(height: DsfrSpacings.s2w),
                  const Text(
                    Localisation.vosAidesTitre,
                    style: DsfrTextStyle.headline2(),
                  ),
                  const SizedBox(height: DsfrSpacings.s1w),
                  const Text(
                    Localisation.vosAidesSousTitre,
                    style: DsfrTextStyle.bodyMd(),
                  ),
                  const SizedBox(height: DsfrSpacings.s3w),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ColoredBox(
                      color: DsfrColors.blueFranceSun113,
                      child: SizedBox(width: 30, height: 2),
                    ),
                  ),
                  _Aides(aides: aides),
                ],
              ),
              const SafeArea(child: SizedBox()),
            ],
          );
        },
        bloc: bloc,
      ),
    );
  }
}

class _Aides extends StatelessWidget {
  const _Aides({required this.aides});

  final List<AidesModel> aides;

  @override
  Widget build(final BuildContext context) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
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
          final AideModel a => CarteAide(aide: a.value),
        },
        separatorBuilder: (final context, final index) =>
            const SizedBox(height: DsfrSpacings.s1w),
        itemCount: aides.length,
      );
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(final BuildContext context) =>
      BlocSelector<UtilisateurBloc, UtilisateurState, bool>(
        selector: (final state) => state.utilisateur.aMaVilleCouverte,
        builder: (final context, final state) => state
            ? const SizedBox()
            : BlocBuilder<AidesDisclaimerCubit, AidesDisclaimerState>(
                builder: (final context, final state) => switch (state) {
                  AidesDisclaimerVisible() => DsfrNotice(
                      titre: Localisation.leServiveNeCouvrePasEncoreVotreVille,
                      description: Localisation
                          .leServiveNeCouvrePasEncoreVotreVilleDescription,
                      onClose: () => context
                          .read<AidesDisclaimerCubit>()
                          .closeDisclaimer(),
                    ),
                  AidesDisclaimerNotVisible() => const SizedBox(),
                },
              ),
      );
}
