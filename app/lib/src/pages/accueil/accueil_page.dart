import 'package:app/src/fonctionnalites/authentification/domain/ports/authentification_repository.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  static const name = 'accueil';
  static const path = '/$name';

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) => const AccueilPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s3w),
            child: Column(
              children: [
                const Text(Localisation.bonjour),
                DsfrButton.lg(
                  label: 'Se déconnecter',
                  onTap: () async {
                    await context
                        .read<AuthentificationRepository>()
                        .deconnectionDemandee();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
