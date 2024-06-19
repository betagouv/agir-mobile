import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SupprimerCompteModal extends StatelessWidget {
  const SupprimerCompteModal({super.key});

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            Localisation.supprimerVotreCompteConfirmation,
            style: DsfrFonts.headline4,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          const Text(
            Localisation.supprimerVotreCompteContenu,
            style: DsfrFonts.bodyMd,
          ),
          const Text(
            Localisation.attentionAucuneDonneeNePourraEtreRecuperee,
            style: DsfrFonts.bodyMdBold,
          ),
          const SizedBox(height: DsfrSpacings.s4w),
          DsfrButton(
            label: Localisation.confirmer,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
            onTap: () => GoRouter.of(context).pop(true),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrButton(
            label: Localisation.annuler,
            variant: DsfrButtonVariant.secondary,
            size: DsfrButtonSize.lg,
            onTap: () => GoRouter.of(context).pop(false),
          ),
        ],
      );
}
