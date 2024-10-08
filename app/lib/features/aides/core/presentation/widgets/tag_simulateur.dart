import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class TagSimulateur extends StatelessWidget {
  const TagSimulateur({super.key});

  @override
  Widget build(final BuildContext context) => const DsfrTag.sm(
        label: TextSpan(text: Localisation.simulateur),
        backgroundColor: FnvColors.aideTagBackground,
        foregroundColor: DsfrColors.grey50,
        icon: DsfrIcons.financeMoneyEuroCircleLine,
      );
}
