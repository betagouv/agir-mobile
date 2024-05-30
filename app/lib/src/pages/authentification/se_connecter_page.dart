import 'package:app/src/fonctionnalites/se_connecter/bloc/se_connecter_bloc.dart';
import 'package:app/src/fonctionnalites/se_connecter/bloc/se_connecter_event.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SeConnecterPage extends StatelessWidget {
  const SeConnecterPage({super.key});

  static const name = 'authentification';
  static const path = '/$name';

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) => const SeConnecterPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: Colors.white),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s3w,
              bottom: DsfrSpacings.s3w,
              right: DsfrSpacings.s3w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Localisation.seConnecterAvecSonCompte,
                  style: DsfrFonts.headline1,
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                DsfrInput(
                  label: Localisation.adresseElectronique,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (final value) {
                    context
                        .read<SeConnecterBloc>()
                        .add(SeConnecterAdresseMailAChange(value));
                  },
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                DsfrInput(
                  label: Localisation.motDePasse,
                  keyboardType: TextInputType.visiblePassword,
                  passwordMode: true,
                  onChanged: (final value) {
                    context
                        .read<SeConnecterBloc>()
                        .add(SeConnecterMotDePasseAChange(value));
                  },
                ),
                const Spacer(),
                DsfrButton.lg(
                  label: Localisation.seConnecter,
                  onTap: () {
                    context
                        .read<SeConnecterBloc>()
                        .add(const SeConnecterConnexionDemandee());
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
