import 'package:flutter/rendering.dart';

class _DsfrTextStyle extends TextStyle {
  const _DsfrTextStyle({
    required final double fontSize,
    required final double height,
    super.fontWeight = FontWeight.normal,
  }) : super(
          package: 'dsfr',
          fontFamily: 'Marianne',
          fontSize: fontSize,
          height: height / fontSize,
        );
}

class DsfrFonts {
  const DsfrFonts._();

  static const displayXl = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 72,
    height: 80,
  );

  static const displayLg = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 64,
    height: 72,
  );

  static const displayMd = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 56,
    height: 64,
  );

  static const displaySm = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48,
    height: 56,
  );

  static const displayXs = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40,
    height: 48,
  );

  static const headline1 = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 32,
    height: 40,
  );

  static const headline2 = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    height: 36,
  );

  static const headline3 = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 32,
  );

  static const headline4 = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    height: 28,
  );

  static const headline5 = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    height: 28,
  );

  static const headline6 = _DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 24,
  );

  static const bodyXl = _DsfrTextStyle(
    fontSize: 20,
    height: 32,
  );

  static const bodyLg = _DsfrTextStyle(
    fontSize: 18,
    height: 28,
  );

  static const bodyLgMedium = _DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 28,
  );

  static const bodyMd = _DsfrTextStyle(
    fontSize: 16,
    height: 24,
  );

  static const bodyMdMedium = _DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24,
  );

  static const bodySm = _DsfrTextStyle(
    fontSize: 14,
    height: 24,
  );

  static const bodySmMedium = _DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 24,
  );

  static const bodyXs = _DsfrTextStyle(
    fontSize: 12,
    height: 20,
  );
}
