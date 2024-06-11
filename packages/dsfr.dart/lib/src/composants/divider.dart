import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

class DsfrDivider extends StatelessWidget {
  const DsfrDivider({super.key});

  @override
  Widget build(final BuildContext context) => const Divider(
        height: 0,
        thickness: 0,
        color: DsfrColors.grey900,
      );
}
