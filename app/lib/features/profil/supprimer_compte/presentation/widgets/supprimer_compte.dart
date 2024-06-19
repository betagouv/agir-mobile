// ignore_for_file: move-variable-closer-to-its-usage

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/features/profil/supprimer_compte/presentation/blocs/supprimer_compte_bloc.dart';
import 'package:app/features/profil/supprimer_compte/presentation/blocs/supprimer_compte_event.dart';
import 'package:app/features/profil/supprimer_compte/presentation/widgets/supprimer_compte_modal.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupprimerCompte extends StatelessWidget {
  const SupprimerCompte({super.key});

  Future<void> _handleSupprimerCompte(final BuildContext context) async {
    final authentificationPort = context.read<AuthentificationPort>();
    final profilPort = context.read<ProfilPort>();
    final result = await DsfrModal.showModal<bool>(
      context: context,
      builder: (final context) => const SupprimerCompteModal(),
    );
    if (result != null && result) {
      final bloc = SupprimerCompteBloc(
        authentificationPort: authentificationPort,
        profilPort: profilPort,
      )..add(const SupprimerCompteSuppressionDemandee());
      await bloc.close();
    }
  }

  @override
  Widget build(final BuildContext context) {
    const color = DsfrColors.error425;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ProfilTitrePartie(titre: Localisation.supprimerVotreCompte),
        const SizedBox(height: DsfrSpacings.s2w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(
                DsfrIcons.systemFrInfoFill,
                size: 16,
                color: color,
              ),
            ),
            const SizedBox(width: DsfrSpacings.s1v),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: Localisation.supprimerVotreCompteContenu,
                    ),
                    TextSpan(
                      text: Localisation
                          .attentionAucuneDonneeNePourraEtreRecuperee,
                      style: DsfrFonts.bodyXsBold.copyWith(color: color),
                    ),
                  ],
                ),
                style: DsfrFonts.bodyXs.copyWith(color: color),
              ),
            ),
          ],
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        DsfrButton(
          label: Localisation.supprimerVotreCompte,
          icon: DsfrIcons.systemFrWarningLine,
          variant: DsfrButtonVariant.secondary,
          size: DsfrButtonSize.lg,
          onTap: () async => _handleSupprimerCompte(context),
        ),
      ],
    );
  }
}
