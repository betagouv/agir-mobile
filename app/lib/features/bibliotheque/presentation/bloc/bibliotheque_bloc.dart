import 'package:app/features/bibliotheque/infrastructure/bibliotheque_repository.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BibliothequeBloc extends Bloc<BibliothequeEvent, BibliothequeState> {
  BibliothequeBloc({required final BibliothequeRepository repository}) : super(const BibliothequeState.empty()) {
    on<BibliothequeRecuperationDemandee>((final event, final emit) async {
      emit(state.copyWith(statut: BibliothequeStatut.chargement));
      final result = await repository.recuperer(thematiques: null, titre: null, isFavorite: null);
      result.fold((final l) => null, (final r) => emit(state.copyWith(bibliotheque: r, statut: BibliothequeStatut.succes)));
    });
    on<BibliothequeRechercheSaisie>((final event, final emit) async {
      final recherche = event.valeur;
      final result = await repository.recuperer(thematiques: state.thematiques, titre: recherche, isFavorite: state.isFavorites);
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(bibliotheque: r, recherche: recherche, statut: BibliothequeStatut.succes)),
      );
    });
    on<BibliothequeThematiqueSelectionnee>((final event, final emit) async {
      final thematiques = state.thematiques.toList();
      thematiques.contains(event.valeur) ? thematiques.remove(event.valeur) : thematiques.add(event.valeur);
      final result = await repository.recuperer(thematiques: thematiques, titre: state.recherche, isFavorite: state.isFavorites);
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(bibliotheque: r, thematiques: thematiques, statut: BibliothequeStatut.succes)),
      );
    });
    on<BibliothequeFavorisSelectionnee>((final event, final emit) async {
      final result = await repository.recuperer(thematiques: state.thematiques, titre: state.recherche, isFavorite: event.valeur);
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(bibliotheque: r, isFavorites: event.valeur, statut: BibliothequeStatut.succes)),
      );
    });
  }
}
