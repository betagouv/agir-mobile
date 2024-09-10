import 'package:app/features/bibliotheque/domain/ports/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class BibliothequeBloc extends Bloc<BibliothequeEvent, BibliothequeState> {
  BibliothequeBloc({required final BibliothequePort bibliothequePort})
      : super(const BibliothequeState.empty()) {
    on<BibliothequeRecuperationDemandee>((final event, final emit) async {
      emit(state.copyWith(statut: BibliothequeStatut.chargement));
      final result = await bibliothequePort.recuperer();
      if (result.isRight()) {
        final bibliotheque =
            result.getRight().getOrElse(() => throw Exception());
        emit(
          state.copyWith(
            bibliotheque: bibliotheque,
            statut: BibliothequeStatut.succes,
          ),
        );
      }
    });
    on<BibliothequeRechercheSaisie>((final event, final emit) async {
      final result = await bibliothequePort.recuperer(
        thematiques: state.thematiques,
        titre: event.valeur,
      );
      if (result.isRight()) {
        final bibliotheque =
            result.getRight().getOrElse(() => throw Exception());
        emit(
          state.copyWith(
            bibliotheque: bibliotheque,
            statut: BibliothequeStatut.succes,
          ),
        );
      }
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
      if (result.isRight()) {
        final bibliotheque =
            result.getRight().getOrElse(() => throw Exception());
        emit(
          state.copyWith(
            bibliotheque: bibliotheque,
            thematiques: thematiques,
            statut: BibliothequeStatut.succes,
          ),
        );
      }
    });
  }
}
