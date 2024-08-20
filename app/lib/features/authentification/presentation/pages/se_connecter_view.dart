import 'package:app/features/authentification/presentation/blocs/se_connecter_bloc.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_event.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_state.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/alert.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              Localisation.seConnecter,
              style: DsfrTextStyle.headline2(),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            DsfrInput(
              label: Localisation.adresseEmail,
              onChanged: (final value) => _handleAdresseMail(context, value),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            DsfrInput(
              label: Localisation.motDePasse,
              onChanged: (final value) => _handleMotDePasse(context, value),
              isPasswordMode: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const _MessageErreur(),
            const Spacer(),
            BlocSelector<SeConnecterBloc, SeConnecterState, bool>(
              selector: (final state) => state.estValide,
              builder: (final context, final state) => DsfrButton(
                label: Localisation.seConnecter,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: state ? () => _handleSeConnecter(context) : null,
              ),
            ),
          ],
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
      .match(
        () => const SizedBox.shrink(),
        (final t) => Column(
          children: [
            const SizedBox(height: DsfrSpacings.s2w),
            FnvAlert.error(label: t),
          ],
        ),
      );
}
