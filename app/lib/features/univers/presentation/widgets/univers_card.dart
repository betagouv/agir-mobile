import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class UniversCard extends StatelessWidget {
  const UniversCard({super.key, required this.child, this.badge, this.onTap});

  final Widget child;
  final Widget? badge;
  final GestureTapCallback? onTap;

  @override
  Widget build(final BuildContext context) => Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: GestureDetector(
              onTap: onTap,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shadows: recommandationOmbre,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: DsfrSpacings.s1w,
                    top: DsfrSpacings.s1w,
                    right: DsfrSpacings.s1w,
                    bottom: DsfrSpacings.s3v,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          if (badge != null) badge!,
        ],
      );
}
