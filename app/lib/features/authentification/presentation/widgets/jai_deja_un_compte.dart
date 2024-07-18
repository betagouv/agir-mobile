import 'package:app/features/authentification/presentation/pages/se_connecter_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class JaiDejaUnCompteWidget extends StatelessWidget {
  const JaiDejaUnCompteWidget({super.key});

  Future<void> _handleAllerASeConnecter(final BuildContext context) async {
    await GoRouter.of(context).pushNamed(SeConnecterPage.name);
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: DsfrLink.md(
          label: Localisation.jaiDejaUnCompte,
          onPressed: () async => _handleAllerASeConnecter(context),
        ),
      );
}
