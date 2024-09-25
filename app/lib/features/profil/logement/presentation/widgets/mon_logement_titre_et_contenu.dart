import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MonLogementTitreEtContenu extends StatelessWidget {
  const MonLogementTitreEtContenu({
    super.key,
    required this.titre,
    required this.contenu,
  });

  final String titre;
  final Widget contenu;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilTitrePartie(titre: titre),
          const SizedBox(height: DsfrSpacings.s2w),
          contenu,
        ],
      );
}
