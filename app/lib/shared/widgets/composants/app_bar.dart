import 'package:app/features/gamification/presentation/widgets/points.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const preferredHeight = 59.0;

class FnvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FnvAppBar({this.leading, this.title, super.key});

  final Widget? leading;
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
              padding: const EdgeInsets.only(
                left: DsfrSpacings.s1w,
                right: DsfrSpacings.s3w,
              ),
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
                          shape: WidgetStatePropertyAll(
                            roundedRectangleBorder,
                          ),
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
                  if (title == null)
                    const Spacer()
                  else ...[
                    const SizedBox(width: DsfrSpacings.s1w),
                    Expanded(child: title!),
                  ],
                  const SizedBox(width: DsfrSpacings.s1w),
                  const Points(),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(preferredHeight);
}
