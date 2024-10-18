import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class _MosaicButtonStyle {
  const _MosaicButtonStyle._({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.textStyle,
  });

  const _MosaicButtonStyle.selected()
      : this._(
          backgroundColor: const Color(0xfff3f3f8),
          borderColor: DsfrColors.blueFranceSun113,
          borderWidth: 3,
          textStyle: const DsfrTextStyle.bodySmBold(
            color: DsfrColors.blueFranceSun113,
          ),
        );

  const _MosaicButtonStyle.unselected()
      : this._(
          backgroundColor: const Color(0xfff8f8f7),
          borderColor: const Color(0xffe3e3db),
          borderWidth: 1,
          textStyle: const DsfrTextStyle.bodySmMedium(),
        );

  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final DsfrTextStyle textStyle;
}

abstract final class _MosaicButtonStyles {
  static const selected = _MosaicButtonStyle.selected();
  static const unselected = _MosaicButtonStyle.unselected();
  static const borderRadius =
      BorderRadius.all(Radius.circular(DsfrSpacings.s1w));
  static const minSize = 120.0;
}

class MosaicButton extends StatelessWidget {
  const MosaicButton({
    super.key,
    required this.emoji,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final Widget emoji;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(final BuildContext context) {
    final style =
        value ? _MosaicButtonStyles.selected : _MosaicButtonStyles.unselected;
    final size =
        MediaQuery.textScalerOf(context).scale(_MosaicButtonStyles.minSize);

    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            border:
                Border.all(color: style.borderColor, width: style.borderWidth),
            borderRadius: _MosaicButtonStyles.borderRadius,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: _MosaicButtonStyles.minSize,
              minHeight: _MosaicButtonStyles.minSize,
            ),
            child: SizedBox(
              width: size,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onChanged(!value),
                  borderRadius: _MosaicButtonStyles.borderRadius,
                  child: Padding(
                    padding: const EdgeInsets.all(DsfrSpacings.s1w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        emoji,
                        const SizedBox(height: DsfrSpacings.s1w),
                        Text(
                          title,
                          style: style.textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (value)
          const Positioned(
            top: -14,
            right: -14,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: DsfrColors.blueFranceSun113,
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: 29,
                child: Icon(
                  DsfrIcons.systemCheckLine,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
