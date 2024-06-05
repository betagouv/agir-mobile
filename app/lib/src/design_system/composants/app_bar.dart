import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/design_system/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/src/design_system/fondamentaux/shadows.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const preferredHeight = 59.0;

class FnvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FnvAppBar({this.leading, this.title, super.key});

  final IconButton? leading;
  final Widget? title;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: FnvColors.appBarFond,
          shadows: appBarOmbre,
          shape: RoundedRectangleBorder(),
        ),
        child: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: SizedBox(
            height: preferredHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
              child: Row(
                children: [
                  leading ??
                      IconButton(
                        iconSize: 24,
                        padding: const EdgeInsets.all(DsfrSpacings.s1w),
                        onPressed: () => GoRouter.of(context).canPop()
                            ? GoRouter.of(context).pop()
                            : Scaffold.of(context).openDrawer(),
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(roundedRectangleBorder),
                        ),
                        icon: Icon(
                          GoRouter.of(context).canPop()
                              ? DsfrIcons.systemArrowLeftLine
                              : DsfrIcons.systemMenuFill,
                          color: DsfrColors.blueFranceSun113,
                          semanticLabel: GoRouter.of(context).canPop()
                              ? Localisation.retour
                              : Localisation.menu,
                        ),
                      ),
                  if (title != null) ...[
                    const SizedBox(width: DsfrSpacings.s1w),
                    Expanded(child: title!),
                  ],
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(preferredHeight);
}
