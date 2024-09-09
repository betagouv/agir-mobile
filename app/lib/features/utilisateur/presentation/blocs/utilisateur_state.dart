import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:equatable/equatable.dart';

final class UtilisateurState extends Equatable {
  const UtilisateurState({required this.utilisateur});

  final Utilisateur utilisateur;

  @override
  List<Object?> get props => [utilisateur];
}
