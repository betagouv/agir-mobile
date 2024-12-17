import 'package:app/core/helpers/regex.dart';
import 'package:flutter/material.dart';

enum ThemeType {
  alimentation(
    routeCode: 'me-nourrir',
    displayName: '🥗 Me nourrir',
    backgroundColor: Color(0xFFE3FBAF),
    foregroundColor: Color(0xFF175202),
  ),
  transport(
    routeCode: 'me-deplacer',
    displayName: '🚗 Me déplacer',
    backgroundColor: Color(0xFFD2E9FF),
    foregroundColor: Color(0xFF021952),
  ),
  logement(
    routeCode: 'me-loger',
    displayName: '🏠 Me loger',
    backgroundColor: Color(0xFFFFE2E0),
    foregroundColor: Color(0xFF52022E),
  ),
  consommation(
    routeCode: 'consommer',
    displayName: '👕 Consommer',
    backgroundColor: Color(0xFFFFE8D7),
    foregroundColor: Color(0xFF522E02),
  ),
  decouverte(
    routeCode: 'decouverte',
    displayName: 'Découverte',
    backgroundColor: Color(0xFFDDEDEA),
    foregroundColor: Color(0xFF024452),
  );

  const ThemeType({
    required this.routeCode,
    required this.displayName,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String routeCode;
  final String displayName;
  String get displayNameWithoutEmoji => removeEmoji(displayName).trim();
  final Color backgroundColor;
  final Color foregroundColor;
}
