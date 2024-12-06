import 'package:app/features/utilisateur/domain/utilisateur.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class UtilisateurState extends Equatable {
  const UtilisateurState({required this.utilisateur});

  final Utilisateur utilisateur;

  @override
  List<Object?> get props => [utilisateur];
}
