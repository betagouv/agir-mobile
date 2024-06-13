import 'package:app/src/l10n/l10n.dart';
import 'package:app/src/pages/authentification/se_connecter_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class JaiDejaUnCompteWidget extends StatelessWidget {
  const JaiDejaUnCompteWidget({super.key});

  Future<void> _handleAllerASeConnecter(final BuildContext context) async {
    await context.pushNamed(SeConnecterPage.name);
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: DsfrLink.md(
          label: Localisation.jaiDejaUnCompte,
          onTap: () async => _handleAllerASeConnecter(context),
        ),
      );
}
