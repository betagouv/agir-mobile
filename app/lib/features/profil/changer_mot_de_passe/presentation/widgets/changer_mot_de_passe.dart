import 'package:app/features/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';

class ChangerMotDePasse extends StatelessWidget {
  const ChangerMotDePasse({super.key});

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfilTitrePartie(titre: Localisation.changerVotreMotDePasse),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrInput(
            label: Localisation.motDePasse,
            onChanged: (final value) {},
            isPasswordMode: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrButton(
            label: Localisation.changerVotreMotDePasse,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
            onTap: () {},
          ),
        ],
      );
}
