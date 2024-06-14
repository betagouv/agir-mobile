import 'package:app/features/profil/presentation/widgets/mes_informations_email.dart';
import 'package:app/features/profil/presentation/widgets/mes_informations_nom.dart';
import 'package:app/features/profil/presentation/widgets/mes_informations_nombre_de_parts_fiscales.dart';
import 'package:app/features/profil/presentation/widgets/mes_informations_prenom.dart';
import 'package:app/features/profil/presentation/widgets/mes_informations_revenu_fiscal.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MesInformationsForm extends StatelessWidget {
  const MesInformationsForm({super.key});

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(
          vertical: DsfrSpacings.s3w,
          horizontal: DsfrSpacings.s2w,
        ),
        children: [
          const ProfilTitle(title: Localisation.mesInformations),
          const Text(Localisation.votreIdentite, style: DsfrFonts.headline4),
          const SizedBox(height: DsfrSpacings.s2w),
          const MesInformationsPrenom(),
          const SizedBox(height: DsfrSpacings.s2w),
          const MesInformationsNom(),
          const SizedBox(height: DsfrSpacings.s2w),
          const MesInformationsEmail(),
          const SizedBox(height: DsfrSpacings.s5w),
          const Text(
            Localisation.donneesPersonnelles,
            style: DsfrFonts.headline4,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          const MesInformationsNombreDePartsFiscales(),
          const SizedBox(height: DsfrSpacings.s2w),
          const MesInformationsRevenuFiscal(),
          const SizedBox(height: DsfrSpacings.s2w),
          DecoratedBox(
            decoration: const ShapeDecoration(
              color: DsfrColors.info950,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: DsfrColors.blueFranceMain525),
                borderRadius: BorderRadius.all(
                  Radius.circular(DsfrSpacings.s1w),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Row(
                children: [
                  const Icon(
                    DsfrIcons.systemQuestionLine,
                    color: DsfrColors.blueFranceSun113,
                  ),
                  const SizedBox(width: DsfrSpacings.s1w),
                  Expanded(
                    child: MarkdownBody(
                      data: Localisation.pourquoiCesQuestionsReponse,
                      styleSheet: MarkdownStyleSheet(
                        p: const DsfrTextStyle(fontSize: 15, lineHeight: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
