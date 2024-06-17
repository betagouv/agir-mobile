import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_chauffage.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_code_postal_et_commune.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_dpe.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_est_proprietaire.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_nombre_adultes.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_nombre_enfants.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_plus_15_ans.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_residence_principale.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_superficie.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/features/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MonLogementForm extends StatelessWidget {
  const MonLogementForm({super.key});

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(
          vertical: DsfrSpacings.s3w,
          horizontal: DsfrSpacings.s2w,
        ),
        children: const [
          ProfilTitle(title: Localisation.monLogement),
          MonLogementCodePostalEtCommune(),
          SizedBox(height: DsfrSpacings.s6w),
          ProfilTitrePartie(
            titre: Localisation.combienEtesVousDansVotreLogement,
          ),
          SizedBox(height: DsfrSpacings.s2w),
          MonLogementNombreAdultes(),
          SizedBox(height: DsfrSpacings.s2w),
          MonLogementNombreEnfants(),
          SizedBox(height: DsfrSpacings.s6w),
          MonLogementResidencePrincipale(),
          SizedBox(height: DsfrSpacings.s6w),
          MonLogementEstProprietaire(),
          SizedBox(height: DsfrSpacings.s6w),
          MonLogementSuperficie(),
          SizedBox(height: DsfrSpacings.s6w),
          MonLogementChauffage(),
          SizedBox(height: DsfrSpacings.s6w),
          MonLogementPlus15Ans(),
          SizedBox(height: DsfrSpacings.s6w),
          MonLogementDpe(),
        ],
      );
}
