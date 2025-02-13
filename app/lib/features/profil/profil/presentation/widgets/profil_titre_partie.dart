import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ProfilTitrePartie extends StatelessWidget {
  const ProfilTitrePartie({super.key, required this.titre});

  final String titre;

  @override
  Widget build(final context) => Text(titre, style: const DsfrTextStyle.headline4());
}
