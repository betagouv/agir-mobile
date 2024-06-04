import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DsfrTag extends StatelessWidget {
  const DsfrTag._({
    required this.label,
    required this.textStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.padding,
    this.icon,
    this.onTap,
    super.key,
  });

  const DsfrTag.sm({
    required final InlineSpan label,
    required final Color backgroundColor,
    required final Color foregroundColor,
    final IconData? icon,
    final GestureTapCallback? onTap,
    final Key? key,
  }) : this._(
          label: label,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: DsfrFonts.bodyXs,
          padding: const EdgeInsets.symmetric(
            horizontal: DsfrSpacings.s1w,
            vertical: DsfrSpacings.s0v5,
          ),
          icon: icon,
          onTap: onTap,
          key: key,
        );

  const DsfrTag.md({
    required final InlineSpan label,
    required final Color backgroundColor,
    required final Color foregroundColor,
    final IconData? icon,
    final GestureTapCallback? onTap,
    final Key? key,
  }) : this._(
          label: label,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: DsfrFonts.bodySm,
          padding: const EdgeInsets.symmetric(
            horizontal: DsfrSpacings.s3v,
            vertical: DsfrSpacings.s1v,
          ),
          icon: icon,
          onTap: onTap,
          key: key,
        );

  final IconData? icon;
  final InlineSpan label;
  final GestureTapCallback? onTap;

  final TextStyle textStyle;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsets padding;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: backgroundColor,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Text.rich(
              TextSpan(
                children: [
                  if (icon != null) ...[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        icon,
                        size: DsfrSpacings.s3v,
                        color: foregroundColor,
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: DsfrSpacings.s1v),
                    ),
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
