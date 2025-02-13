import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:equatable/equatable.dart';

class Bibliotheque extends Equatable {
  const Bibliotheque({required this.contenus, required this.filtres});

  final List<Recommandation> contenus;
  final List<BibliothequeFiltre> filtres;

  @override
  List<Object> get props => [contenus, filtres];
}

class BibliothequeFiltre extends Equatable {
  const BibliothequeFiltre({required this.code, required this.titre, required this.choisi});

  final String code;
  final String titre;
  final bool choisi;

  @override
  List<Object?> get props => [code, titre, choisi];
}
