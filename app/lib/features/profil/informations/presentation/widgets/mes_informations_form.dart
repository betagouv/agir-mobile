import 'package:app/features/profil/informations/presentation/widgets/mes_informations_email.dart';
import 'package:app/features/profil/informations/presentation/widgets/mes_informations_nom.dart';
import 'package:app/features/profil/informations/presentation/widgets/mes_informations_nombre_de_parts_fiscales.dart';
import 'package:app/features/profil/informations/presentation/widgets/mes_informations_prenom.dart';
import 'package:app/features/profil/informations/presentation/widgets/mes_informations_revenu_fiscal.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/features/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/alert_info.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MesInformationsForm extends StatelessWidget {
  const MesInformationsForm({super.key});

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: const [
          ProfilTitle(title: Localisation.vosInformations),
          ProfilTitrePartie(titre: Localisation.votreIdentite),
          SizedBox(height: DsfrSpacings.s2w),
          MesInformationsPrenom(),
          SizedBox(height: DsfrSpacings.s2w),
          MesInformationsNom(),
          SizedBox(height: DsfrSpacings.s2w),
          MesInformationsEmail(),
          SizedBox(height: DsfrSpacings.s5w),
          ProfilTitrePartie(titre: Localisation.donneesPersonnelles),
          SizedBox(height: DsfrSpacings.s2w),
          MesInformationsNombreDePartsFiscales(),
          SizedBox(height: DsfrSpacings.s2w),
          MesInformationsRevenuFiscal(),
          SizedBox(height: DsfrSpacings.s2w),
          FnvAlertInfo(label: Localisation.pourquoiCesQuestionsReponse),
        ],
      );
}
