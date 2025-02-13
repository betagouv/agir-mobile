// ignore_for_file: move-variable-closer-to-its-usage

import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/features/profil/supprimer_compte/presentation/bloc/supprimer_compte_bloc.dart';
import 'package:app/features/profil/supprimer_compte/presentation/bloc/supprimer_compte_event.dart';
import 'package:app/features/profil/supprimer_compte/presentation/widgets/supprimer_compte_modal.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupprimerCompte extends StatelessWidget {
  const SupprimerCompte({super.key});

  @override
  Widget build(final context) {
    const color = DsfrColors.error425;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const ProfilTitrePartie(titre: Localisation.supprimerVotreCompte),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s1v,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(DsfrIcons.systemFrInfoFill, size: 16, color: color),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: Localisation.supprimerVotreCompteContenu),
                    TextSpan(text: ' '),
                    TextSpan(
                      text:
                          Localisation
                              .attentionAucuneDonneeNePourraEtreRecuperee,
                      style: DsfrTextStyle.bodyXsBold(color: color),
                    ),
                  ],
                ),
                style: DsfrTextStyle.bodyXs(color: color),
              ),
            ),
          ],
        ),
        DsfrButton(
          label: Localisation.supprimerVotreCompte,
          icon: DsfrIcons.systemFrWarningLine,
          variant: DsfrButtonVariant.secondary,
          foregroundColor: color,
          size: DsfrButtonSize.lg,
          onPressed: () async {
            final bloc = SupprimerCompteBloc(
              authentificationRepository: context.read(),
              profilRepository: context.read(),
            );
            final result = await DsfrModal.showModal<bool>(
              context: context,
              builder: (final context) => const SupprimerCompteModal(),
              name: 'supprimer-compte',
            );
            if (result != null && result) {
              bloc.add(const SupprimerCompteSuppressionDemandee());
            }
          },
        ),
      ],
    );
  }
}
