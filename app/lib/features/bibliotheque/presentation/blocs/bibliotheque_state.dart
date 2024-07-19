import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:equatable/equatable.dart';

enum BibliothequeStatut { initial, chargement, succes }

final class BibliothequeState extends Equatable {
  const BibliothequeState({
    required this.bibliotheque,
    required this.recherche,
    required this.thematiques,
    required this.statut,
  });

  const BibliothequeState.empty()
      : this(
          bibliotheque: const Bibliotheque(contenus: [], filtres: []),
          recherche: '',
          thematiques: const [],
          statut: BibliothequeStatut.initial,
        );

  final Bibliotheque bibliotheque;
  final String recherche;
  final List<String> thematiques;
  final BibliothequeStatut statut;

  BibliothequeState copyWith({
    final Bibliotheque? bibliotheque,
    final String? recherche,
    final List<String>? thematiques,
    final BibliothequeStatut? statut,
  }) =>
      BibliothequeState(
        bibliotheque: bibliotheque ?? this.bibliotheque,
        recherche: recherche ?? this.recherche,
        thematiques: thematiques ?? this.thematiques,
        statut: statut ?? this.statut,
      );

  @override
  List<Object?> get props => [bibliotheque, recherche, thematiques, statut];
}
