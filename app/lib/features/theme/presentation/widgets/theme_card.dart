import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({super.key, required this.child, this.badge, this.onTap});

  final Widget child;
  final Widget? badge;
  final GestureTapCallback? onTap;

  @override
  Widget build(final context) => Stack(
    alignment: Alignment.topCenter,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 11),
        child: _Card(onTap: onTap, child: child),
      ),
      if (badge != null) badge!,
    ],
  );
}

class _Card extends StatefulWidget {
  const _Card({required this.onTap, required this.child});

  final GestureTapCallback? onTap;
  final Widget child;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> with MaterialStateMixin<_Card> {
  @override
  Widget build(final BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return DsfrFocusWidget(
      isFocused: isFocused,
      borderRadius: borderRadius,
      child: Material(
        color: FnvColors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: updateMaterialState(WidgetState.pressed),
          onHover: updateMaterialState(WidgetState.hovered),
          focusColor: FnvColors.transparent,
          borderRadius: borderRadius,
          onFocusChange: updateMaterialState(WidgetState.focused),
          child: DecoratedBox(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: recommandationOmbre,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: DsfrSpacings.s1w,
                top: DsfrSpacings.s1w,
                right: DsfrSpacings.s1w,
                bottom: DsfrSpacings.s3v,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
