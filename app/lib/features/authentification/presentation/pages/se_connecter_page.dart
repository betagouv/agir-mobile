import 'package:app/features/authentification/presentation/blocs/se_connecter_bloc.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_event.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SeConnecterPage extends StatelessWidget {
  const SeConnecterPage({super.key});

  static const name = 'authentification';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const SeConnecterPage(),
      );

  void _handleAdresseMail(final BuildContext context, final String value) {
    context.read<SeConnecterBloc>().add(SeConnecterAdresseMailAChange(value));
  }

  void _handleMotDePasse(final BuildContext context, final String value) {
    context.read<SeConnecterBloc>().add(SeConnecterMotDePasseAChange(value));
  }

  void _handleSeConnecter(final BuildContext context) {
    context.read<SeConnecterBloc>().add(const SeConnecterConnexionDemandee());
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s3w,
              right: DsfrSpacings.s3w,
              bottom: DsfrSpacings.s3w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  Localisation.seConnecter,
                  style: DsfrTextStyle.headline1(),
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                DsfrInput(
                  label: Localisation.adresseElectronique,
                  onChanged: (final value) =>
                      _handleAdresseMail(context, value),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                DsfrInput(
                  label: Localisation.motDePasse,
                  onChanged: (final value) => _handleMotDePasse(context, value),
                  isPasswordMode: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
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
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
}
