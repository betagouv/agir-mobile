import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/design_system/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/src/design_system/fondamentaux/shadows.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FnvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FnvAppBar({
    this.leading,
    this.title,
    this.preferredHeight = 59,
    super.key,
  });

  final IconButton? leading;
  final Widget? title;
  final double preferredHeight;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: FnvColors.appBarFond,
          shadows: appBarOmbre,
        ),
        child: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: SizedBox(
            height: preferredHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
              child: Row(
                children: [
                  leading ??
                      IconButton(
                        icon: Icon(
                          GoRouter.of(context).canPop()
                              ? DsfrIcons.systemArrowLeftLine
                              : DsfrIcons.systemMenuFill,
                          color: DsfrColors.blueFranceSun113,
                          semanticLabel: GoRouter.of(context).canPop()
                              ? Localisation.retour
                              : Localisation.menu,
                        ),
                        iconSize: 24,
                        padding: const EdgeInsets.all(DsfrSpacings.s1w),
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(roundedRectangleBorder),
                        ),
                        onPressed: () => GoRouter.of(context).canPop()
                            ? GoRouter.of(context).pop()
                            : Scaffold.of(context).openDrawer(),
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
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
