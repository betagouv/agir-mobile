import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:equatable/equatable.dart';

enum BibliothequeStatut { initial, chargement, succes }

final class BibliothequeState extends Equatable {
  const BibliothequeState({required this.bibliotheque, required this.statut});

  const BibliothequeState.empty()
      : this(
          bibliotheque: const Bibliotheque(contenus: [], filtres: []),
          statut: BibliothequeStatut.initial,
        );

  final Bibliotheque bibliotheque;
  final BibliothequeStatut statut;

  BibliothequeState copyWith({
    final Bibliotheque? bibliotheque,
    final BibliothequeStatut? statut,
  }) =>
      BibliothequeState(
        bibliotheque: bibliotheque ?? this.bibliotheque,
        statut: statut ?? this.statut,
      );

  @override
  List<Object?> get props => [bibliotheque, statut];
}
