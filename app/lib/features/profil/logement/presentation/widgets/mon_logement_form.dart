import 'package:app/features/profil/logement/presentation/widgets/mon_logement_chauffage.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_code_postal_et_commune.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_combien_etes_vous.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_dpe.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_est_proprietaire.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_plus_15_ans.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_residence_principale.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_superficie.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MonLogementForm extends StatelessWidget {
  const MonLogementForm({super.key});

  @override
  Widget build(final BuildContext context) {
    const gap = SizedBox(height: DsfrSpacings.s3w);

    return ListView(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      children: const [
        ProfilTitle(title: Localisation.votreLogement),
        MonLogementCodePostalEtCommune(),
        gap,
        MonLogementCombienEtesVous(),
        gap,
        MonLogementResidencePrincipale(),
        gap,
        MonLogementEstProprietaire(),
        gap,
        MonLogementSuperficie(),
        gap,
        MonLogementChauffage(),
        gap,
        MonLogementPlus15Ans(),
        gap,
        MonLogementDpe(),
      ],
    );
  }
}
