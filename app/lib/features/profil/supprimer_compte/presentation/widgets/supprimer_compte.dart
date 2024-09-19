// ignore_for_file: move-variable-closer-to-its-usage

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
    final bloc = SupprimerCompteBloc(
      authentificationPort: context.read(),
      profilPort: context.read(),
    );
    final result = await DsfrModal.showModal<bool>(
      context: context,
      builder: (final context) => const SupprimerCompteModal(),
      name: 'supprimer-compte',
    );
    if (result != null && result) {
      bloc.add(const SupprimerCompteSuppressionDemandee());
    }
  }

  @override
  Widget build(final BuildContext context) {
    const color = DsfrColors.error425;

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const ProfilTitrePartie(titre: Localisation.supprimerVotreCompte),
        const SizedBox(height: DsfrSpacings.s2w),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(
                DsfrIcons.systemFrInfoFill,
                size: 16,
                color: color,
              ),
            ),
            SizedBox(width: DsfrSpacings.s1v),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: Localisation.supprimerVotreCompteContenu),
                    TextSpan(
                      text: Localisation
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
        const SizedBox(height: DsfrSpacings.s2w),
        DsfrButton(
          label: Localisation.supprimerVotreCompte,
          icon: DsfrIcons.systemFrWarningLine,
          variant: DsfrButtonVariant.secondary,
          size: DsfrButtonSize.lg,
          onPressed: () async => _handleSupprimerCompte(context),
        ),
      ],
    );
  }
}
