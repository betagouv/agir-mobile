import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ProfilTitrePartie extends StatelessWidget {
  const ProfilTitrePartie({super.key, required this.titre});

  final String titre;

  @override
  Widget build(final BuildContext context) =>
      Text(titre, style: DsfrFonts.headline4);
}
