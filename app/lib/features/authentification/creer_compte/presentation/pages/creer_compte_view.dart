import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/mot_de_passe/mot_de_passe.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_bloc.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_state.dart';
import 'package:app/features/authentification/creer_compte/presentation/widgets/jaccepte.dart';
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

  void _handleAdresseMail(final BuildContext context, final String value) {
    context.read<CreerCompteBloc>().add(CreerCompteAdresseMailAChangee(value));
  }

  void _handleMotDePasse(final BuildContext context, final String value) {
    context.read<CreerCompteBloc>().add(CreerCompteMotDePasseAChange(value));
  }

  Future<void> _handleCompteCree(
    final BuildContext context,
    final String email,
  ) async =>
      GoRouter.of(context).pushNamed(
        SaisieCodePage.name,
        pathParameters: {'email': email},
      );

  @override
  Widget build(final BuildContext context) =>
      BlocListener<CreerCompteBloc, CreerCompteState>(
        listener: (final context, final state) async =>
            _handleCompteCree(context, state.adresseMail),
        listenWhen: (final previous, final current) =>
            previous.compteCree != current.compteCree && current.compteCree,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
          ),
          body: ListView(
            padding: const EdgeInsets.all(paddingVerticalPage),
            children: [
              const Text(
                Localisation.creezMonCompteApp,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              DsfrInput(
                label: Localisation.adresseEmail,
                onChanged: (final value) => _handleAdresseMail(context, value),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              FnvMotDePasse(
                onChanged: (final value) => _handleMotDePasse(context, value),
              ),
              const _MessageErreur(),
              const SizedBox(height: DsfrSpacings.s2w),
              const _Cgu(),
              const SizedBox(height: DsfrSpacings.s3w),
              const _BoutonCreerCompte(),
              const SizedBox(height: DsfrSpacings.s2w),
              Center(
                child: DsfrLink.md(
                  label: Localisation.vousAvezDejaUnCompte,
                  onTap: () async => GoRouter.of(context)
                      .pushReplacementNamed(SeConnecterPage.name),
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
  Widget build(final BuildContext context) {
    final valeur = context.select<CreerCompteBloc, bool>(
      (final bloc) => bloc.state.aCguAcceptees,
    );

    return Jaccepte(
      label: Localisation.lesCgu,
      url: Localisation.lesCguSite,
      value: valeur,
      onChanged: (final value) =>
          context.read<CreerCompteBloc>().add(CreerCompteCguAChange(value)),
    );
  }
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final BuildContext context) => context
      .select<CreerCompteBloc, Option<String>>(
        (final bloc) => bloc.state.erreur,
      )
      .fold(
        () => const SizedBox.shrink(),
        (final t) => Column(
          children: [
            const SizedBox(height: DsfrSpacings.s2w),
            FnvAlert.error(label: t),
          ],
        ),
      );
}

class _BoutonCreerCompte extends StatelessWidget {
  const _BoutonCreerCompte();

  @override
  Widget build(final BuildContext context) {
    final estValide = context.select<CreerCompteBloc, bool>(
      (final bloc) => bloc.state.estValide,
    );

    return DsfrButton(
      label: Localisation.creerMonCompte,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: estValide
          ? () => context
              .read<CreerCompteBloc>()
              .add(const CreerCompteCreationDemandee())
          : null,
    );
  }
}
