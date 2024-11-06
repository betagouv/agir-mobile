import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class TagSimulateur extends StatelessWidget {
  const TagSimulateur({super.key});

  @override
  Widget build(final context) => const DsfrTag.sm(
        label: TextSpan(text: Localisation.simulateur),
        backgroundColor: Color(0xFFEEF2FF),
        foregroundColor: DsfrColors.blueFranceSun113,
        icon: DsfrIcons.financeMoneyEuroCircleLine,
      );
}
