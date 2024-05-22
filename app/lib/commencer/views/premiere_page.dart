import 'package:agir/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CommencerPremierePage extends StatelessWidget {
  const CommencerPremierePage({super.key});

  @override
  Widget build(final BuildContext context) => const Column(
        children: [
          Text(Localisation.commencerPremierePageContenu),
        ],
      );
}
