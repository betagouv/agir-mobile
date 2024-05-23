import 'package:flutter/rendering.dart';

class DsfrTextStyle extends TextStyle {
  const DsfrTextStyle({
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

  static const displayXl = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 72,
    height: 80,
  );

  static const displayLg = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 64,
    height: 72,
  );

  static const displayMd = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 56,
    height: 64,
  );

  static const displaySm = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48,
    height: 56,
  );

  static const displayXs = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40,
    height: 48,
  );

  static const headline1 = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 32,
    height: 40,
  );

  static const headline2 = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    height: 36,
  );

  static const headline3 = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 32,
  );

  static const headline4 = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    height: 28,
  );

  static const headline5 = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    height: 28,
  );

  static const headline6 = DsfrTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 24,
  );

  static const bodyXl = DsfrTextStyle(
    fontSize: 20,
    height: 32,
  );

  static const bodyXlMedium = DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 32,
  );

  static const bodyLg = DsfrTextStyle(
    fontSize: 18,
    height: 28,
  );

  static const bodyLgMedium = DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 28,
  );

  static const bodyMd = DsfrTextStyle(
    fontSize: 16,
    height: 24,
  );

  static const bodyMdMedium = DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24,
  );

  static const bodySm = DsfrTextStyle(
    fontSize: 14,
    height: 24,
  );

  static const bodySmMedium = DsfrTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 24,
  );

  static const bodyXs = DsfrTextStyle(
    fontSize: 12,
    height: 20,
  );
}
