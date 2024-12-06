import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class MotDePasseState extends Equatable {
  const MotDePasseState({required this.valeur});

  final String valeur;
  bool get douzeCaracteresMinimum => valeur.length >= 12;
  bool get auMoinsUneMajusculeEtUneMinuscule =>
      valeur.contains(RegExp('[A-Z]')) && valeur.contains(RegExp('[a-z]'));
  bool get unCaractereSpecialMinimum => valeur.contains(
        RegExp(r'''[&~»#)‘\-_`{[|`_\\^@)\]=}+%*$£¨!§/:;.?¿\'",§éèêëàâä»]'''),
      );
  bool get unChiffreMinimum => valeur.contains(RegExp(r'\d'));
  bool get estValide =>
      douzeCaracteresMinimum &&
      auMoinsUneMajusculeEtUneMinuscule &&
      unCaractereSpecialMinimum &&
      unChiffreMinimum;

  @override
  List<Object> get props => [valeur];
}
