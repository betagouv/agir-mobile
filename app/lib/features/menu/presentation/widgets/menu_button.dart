import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(final BuildContext context) => IconButton(
        iconSize: 24,
        padding: const EdgeInsets.all(DsfrSpacings.s1w),
        onPressed: () => Scaffold.of(context).openDrawer(),
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(roundedRectangleBorder),
        ),
        icon: const Icon(
          DsfrIcons.systemMenuFill,
          color: DsfrColors.blueFranceSun113,
          semanticLabel: Localisation.menu,
        ),
      );
}
