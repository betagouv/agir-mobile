import 'package:flutter/material.dart';

enum MissionThemeType {
  alimentation(
    displayName: '🥗 Me nourrir',
    backgroundColor: Color(0xFFE3FBAF),
    foregroundColor: Color(0xFF175202),
  ),
  transport(
    displayName: '🚗 Me déplacer',
    backgroundColor: Color(0xFFD2E9FF),
    foregroundColor: Color(0xFF021952),
  ),
  consommation(
    displayName: '👕 Consommer',
    backgroundColor: Color(0xFFFFE8D7),
    foregroundColor: Color(0xFF522E02),
  ),
  logement(
    displayName: '🏠 Me loger',
    backgroundColor: Color(0xFFFFE2E0),
    foregroundColor: Color(0xFF52022E),
  ),
  decouverte(
    displayName: 'Découverte',
    backgroundColor: Color(0xFFDDEDEA),
    foregroundColor: Color(0xFF024452),
  );

  const MissionThemeType({
    required this.displayName,
    required this.backgroundColor,
    required this.foregroundColor,
  });
  final String displayName;
  final Color backgroundColor;
  final Color foregroundColor;
}
