import 'package:app/core/helpers/regex.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ThemeTypeTag extends StatelessWidget {
  const ThemeTypeTag({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) => DsfrTag.sm(
        label: TextSpan(
          text: themeType.displayName,
          semanticsLabel: removeEmoji(themeType.displayName),
        ),
        backgroundColor: themeType.backgroundColor,
        foregroundColor: themeType.foregroundColor,
      );
}
