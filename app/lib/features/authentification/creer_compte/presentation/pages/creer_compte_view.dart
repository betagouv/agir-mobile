import 'package:app/features/authentification/creer_compte/presentation/blocs/creer_compte_bloc.dart';
import 'package:app/features/authentification/creer_compte/presentation/blocs/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/blocs/creer_compte_state.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreerCompteView extends StatelessWidget {
  const CreerCompteView({super.key});

  void _handleAdresseMail(final BuildContext context, final String value) {
    context.read<CreerCompteBloc>().add(CreerCompteAdresseMailAChangee(value));
  }

  void _handleMotDePasse(final BuildContext context, final String value) {
    context.read<CreerCompteBloc>().add(CreerCompteMotDePasseAChange(value));
  }

  void _handleCreerCompte(final BuildContext context) {
    context.read<CreerCompteBloc>().add(const CreerCompteCreationDemandee());
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              Localisation.creezVotreCompte,
              style: DsfrTextStyle.headline2(),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            const Text(
              Localisation.creezVotreCompteDetails,
              style: DsfrTextStyle.bodyXl(),
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
            const SizedBox(height: DsfrSpacings.s2w),
            DsfrButton(
              label: Localisation.creerMonCompte,
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
              onPressed: () => _handleCreerCompte(context),
            ),
          ],
        ),
      );
}
