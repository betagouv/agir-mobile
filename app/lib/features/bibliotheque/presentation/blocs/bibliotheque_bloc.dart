import 'package:app/features/bibliotheque/domain/ports/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BibliothequeBloc extends Bloc<BibliothequeEvent, BibliothequeState> {
  BibliothequeBloc({required final BibliothequePort bibliothequePort})
      : super(const BibliothequeState.empty()) {
    on<BibliothequeRecuperationDemandee>((final event, final emit) async {
      emit(state.copyWith(statut: BibliothequeStatut.chargement));
      final result = await bibliothequePort.recuperer();
      result.fold(
        (final l) => null,
        (final r) => emit(
          state.copyWith(bibliotheque: r, statut: BibliothequeStatut.succes),
        ),
      );
    });
    on<BibliothequeRechercheSaisie>((final event, final emit) async {
      final result = await bibliothequePort.recuperer(
        thematiques: state.thematiques,
        titre: event.valeur,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(
          state.copyWith(bibliotheque: r, statut: BibliothequeStatut.succes),
        ),
      );
    });
    on<BibliothequeThematiqueSelectionnee>((final event, final emit) async {
      final thematiques = state.thematiques.toList();
      thematiques.contains(event.valeur)
          ? thematiques.remove(event.valeur)
          : thematiques.add(event.valeur);
      final result = await bibliothequePort.recuperer(
        thematiques: thematiques,
        titre: state.recherche,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(
          state.copyWith(
            bibliotheque: r,
            thematiques: thematiques,
            statut: BibliothequeStatut.succes,
          ),
        ),
      );
    });
    on<BibliothequeFavorisSelectionnee>((final event, final emit) async {
      final result = await bibliothequePort.recuperer(
        thematiques: state.thematiques,
        titre: state.recherche,
        isFavorite: event.valeur,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(
          state.copyWith(
            bibliotheque: r,
            isFavorites: event.valeur,
            statut: BibliothequeStatut.succes,
          ),
        ),
      );
    });
  }
}
