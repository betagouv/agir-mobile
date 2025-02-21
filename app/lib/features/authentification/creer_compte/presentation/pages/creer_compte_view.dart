import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/mot_de_passe/mot_de_passe.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/core/presentation/widgets/divider_with_text.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_bloc.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_state.dart';
import 'package:app/features/authentification/creer_compte/presentation/widgets/jaccepte.dart';
import 'package:app/features/authentification/france_connect/presentation/widgets/france_connect_section.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class CreerCompteView extends StatelessWidget {
  const CreerCompteView({super.key});

  @override
  Widget build(final context) => BlocListener<CreerCompteBloc, CreerCompteState>(
    listener:
        (final context, final state) async =>
            GoRouter.of(context).pushNamed(SaisieCodePage.name, pathParameters: {'email': state.adresseMail}),
    listenWhen: (final previous, final current) => previous.compteCree != current.compteCree && current.compteCree,
    child: FnvScaffold(
      appBar: AppBar(
        backgroundColor: FnvColors.homeBackground,
        iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
      ),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          const FranceConnectSection(),
          const SizedBox(height: DsfrSpacings.s3w),
          const DividerWithText(),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(Localisation.creerMonCompteApp, style: DsfrTextStyle.headline2()),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrInput(
            label: Localisation.adresseEmail,
            hintText: Localisation.adresseEmailHint,
            onChanged: (final value) => context.read<CreerCompteBloc>().add(CreerCompteAdresseMailAChangee(value)),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          FnvMotDePasse(onChanged: (final value) => context.read<CreerCompteBloc>().add(CreerCompteMotDePasseAChange(value))),
          const _MessageErreur(),
          const SizedBox(height: DsfrSpacings.s2w),
          const _Cgu(),
          const SizedBox(height: DsfrSpacings.s3w),
          const _BoutonCreerCompte(),
          const SizedBox(height: DsfrSpacings.s2w),
          Center(
            child: DsfrLink.md(
              label: Localisation.vousAvezDejaUnCompte,
              onTap: () async => GoRouter.of(context).pushReplacementNamed(SeConnecterPage.name),
            ),
          ),
          const SafeArea(child: SizedBox.shrink()),
        ],
      ),
    ),
  );
}

class _Cgu extends StatelessWidget {
  const _Cgu();

  @override
  Widget build(final context) {
    final valeur = context.select<CreerCompteBloc, bool>((final bloc) => bloc.state.aCguAcceptees);

    return Jaccepte(
      label: Localisation.lesCgu,
      url: Localisation.lesCguSite,
      value: valeur,
      onChanged: (final value) => context.read<CreerCompteBloc>().add(CreerCompteCguAChange(value)),
    );
  }
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final context) => context
      .select<CreerCompteBloc, Option<String>>((final bloc) => bloc.state.erreur)
      .fold(
        () => const SizedBox.shrink(),
        (final t) => Column(children: [const SizedBox(height: DsfrSpacings.s2w), FnvAlert.error(label: t)]),
      );
}

class _BoutonCreerCompte extends StatelessWidget {
  const _BoutonCreerCompte();

  @override
  Widget build(final context) {
    final estValide = context.select<CreerCompteBloc, bool>((final bloc) => bloc.state.estValide);

    return DsfrButton(
      label: Localisation.creerMonCompte,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: estValide ? () => context.read<CreerCompteBloc>().add(const CreerCompteCreationDemandee()) : null,
    );
  }
}
