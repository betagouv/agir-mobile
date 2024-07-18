import 'dart:async';

import 'package:app/features/bibliotheque/domain/ports/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class BibliothequeBloc extends Bloc<BibliothequeEvent, BibliothequeState> {
  BibliothequeBloc({required final BibliothequePort bibliothequePort})
      : _bibliothequePort = bibliothequePort,
        super(const BibliothequeState.empty()) {
    on<BibliothequeRecuperationDemandee>(_onRecuperationDemandee);
  }

  final BibliothequePort _bibliothequePort;

  Future<void> _onRecuperationDemandee(
    final BibliothequeRecuperationDemandee event,
    final Emitter<BibliothequeState> emit,
  ) async {
    emit(state.copyWith(statut: BibliothequeStatut.chargement));
    final result = await _bibliothequePort.recuperer();
    if (result.isRight()) {
      final bibliotheque = result.getRight().getOrElse(() => throw Exception());
      emit(
        state.copyWith(
          bibliotheque: bibliotheque,
          statut: BibliothequeStatut.succes,
        ),
      );
    }
  }
}
