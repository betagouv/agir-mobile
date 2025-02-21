import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrTag extends StatelessWidget {
  const DsfrTag._({
    super.key,
    required this.label,
    required this.textStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.padding,
    this.icon,
    this.onTap,
  });

  const DsfrTag.sm({
    required final InlineSpan label,
    required final Color backgroundColor,
    required final Color foregroundColor,
    final IconData? icon,
    final TextStyle textStyle = const DsfrTextStyle.bodyXs(),
    final GestureTapCallback? onTap,
    final Key? key,
  }) : this._(
         key: key,
         label: label,
         textStyle: textStyle,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
         icon: icon,
         onTap: onTap,
       );

  const DsfrTag.md({
    required final InlineSpan label,
    required final Color backgroundColor,
    required final Color foregroundColor,
    final IconData? icon,
    final TextStyle textStyle = const DsfrTextStyle.bodyMd(),
    final GestureTapCallback? onTap,
    final Key? key,
  }) : this._(
         key: key,
         label: label,
         textStyle: textStyle,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
         icon: icon,
         onTap: onTap,
       );

  final IconData? icon;
  final InlineSpan label;
  final GestureTapCallback? onTap;

  final TextStyle textStyle;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsets padding;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: ShapeDecoration(color: backgroundColor, shape: const StadiumBorder()),
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding,
        child: Text.rich(
          TextSpan(
            children: [
              if (icon != null) ...[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  baseline: TextBaseline.alphabetic,
                  child: Icon(icon, size: 12, color: foregroundColor),
                ),
                const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1v)),
              ],
              label,
            ],
          ),
          style: textStyle.copyWith(color: foregroundColor),
        ),
      ),
    ),
  );
}
