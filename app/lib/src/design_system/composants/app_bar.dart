import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FnvAppBar({
    required this.title,
    this.preferredHeight = 59,
    super.key,
  });

  final Widget title;
  final double preferredHeight;

  @override
  Widget build(final BuildContext context) => SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: SizedBox(
          height: preferredHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    DsfrIcons.systemMenuFill,
                    color: DsfrColors.blueFranceSun113,
                  ),
                  iconSize: 24,
                  padding: const EdgeInsets.all(DsfrSpacings.s1w),
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(FnvColors.accueilFond),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: DsfrSpacings.s1w),
                Expanded(child: title),
              ],
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
