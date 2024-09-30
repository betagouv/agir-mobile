import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_page.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_bloc.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_event.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class SeConnecterView extends StatelessWidget {
  const SeConnecterView({super.key});

  void _handleAdresseMail(final BuildContext context, final String value) {
    context.read<SeConnecterBloc>().add(SeConnecterAdresseMailAChange(value));
  }

  void _handleMotDePasse(final BuildContext context, final String value) {
    context.read<SeConnecterBloc>().add(SeConnecterMotDePasseAChange(value));
  }

  void _handleSeConnecter(final BuildContext context) {
    context.read<SeConnecterBloc>().add(const SeConnecterConnexionDemandee());
  }

  Future<void> _handleConnexionCree(
    final BuildContext context,
    final String email,
  ) async =>
      GoRouter.of(context).pushNamed(
        SaisieCodePage.name,
        pathParameters: {'email': email},
      );

  @override
  Widget build(final BuildContext context) =>
      BlocListener<SeConnecterBloc, SeConnecterState>(
        listener: (final context, final state) async =>
            _handleConnexionCree(context, state.adresseMail),
        listenWhen: (final previous, final current) =>
            previous.connexionFaite != current.connexionFaite &&
            current.connexionFaite,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
          ),
          body: ListView(
            padding: const EdgeInsets.all(paddingVerticalPage),
            children: [
              const Text(
                Localisation.pageConnexionTitre,
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
              DsfrInput(
                label: Localisation.motDePasse,
                onChanged: (final value) => _handleMotDePasse(context, value),
                isPasswordMode: true,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
              ),
              const _MessageErreur(),
              const SizedBox(height: DsfrSpacings.s1w),
              Align(
                alignment: Alignment.centerLeft,
                child: DsfrLink.md(
                  label: Localisation.motDePasseOublie,
                  onTap: () async =>
                      GoRouter.of(context).pushNamed(MotDePasseOubliePage.name),
                ),
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              BlocSelector<SeConnecterBloc, SeConnecterState, bool>(
                selector: (final state) => state.estValide,
                builder: (final context, final state) => DsfrButton(
                  label: Localisation.meConnecter,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrButtonSize.lg,
                  onPressed: state ? () => _handleSeConnecter(context) : null,
                ),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              Center(
                child: DsfrLink.md(
                  label: Localisation.premiereFoisSurAgir,
                  onTap: () async => GoRouter.of(context)
                      .pushReplacementNamed(CreerComptePage.name),
                ),
              ),
              const SafeArea(child: SizedBox.shrink()),
            ],
          ),
        ),
      );
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final BuildContext context) => context
      .select<SeConnecterBloc, Option<String>>(
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
