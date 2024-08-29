import 'package:app/features/aides/presentation/widgets/mes_aides.dart';
import 'package:app/features/authentification/questions/presentation/pages/question_prenom_page.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/univers/presentation/widgets/univers_section.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_bloc.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/shared/widgets/fondamentaux/text_styles.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  static const name = 'accueil';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AccueilPage(),
      );

  Future<void> _handlePasDePrenom(
    final BuildContext context,
    final UtilisateurState state,
  ) async {
    if (!state.estIntegrationTerminee) {
      await GoRouter.of(context).pushNamed(QuestionPrenomPage.name);
    }
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<UtilisateurBloc, UtilisateurState>(
        listener: (final context, final state) async =>
            _handlePasDePrenom(context, state),
        listenWhen: (final previous, final current) =>
            previous.estIntegrationTerminee != current.estIntegrationTerminee,
        child: const RootPage(title: _AppBarTitle(), body: _Body()),
      );
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<UtilisateurBloc>().state;

    const font = FnvTextStyles.appBarTitleStyle;

    return Text.rich(
      TextSpan(
        text: Localisation.bonjour,
        children: [
          TextSpan(
            text: Localisation.prenomExclamation(state.prenom ?? ''),
            style: font,
          ),
        ],
      ),
      style: font.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) {
    context
        .read<UtilisateurBloc>()
        .add(const UtilisateurRecuperationDemandee());

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: paddingVerticalPage),
      children: const [
        UniversSection(),
        SizedBox(height: DsfrSpacings.s4w),
        MesAides(),
        SizedBox(height: DsfrSpacings.s4w),
        MesRecommandations(),
        SafeArea(child: SizedBox()),
      ],
    );
  }
}
