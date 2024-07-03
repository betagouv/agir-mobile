import 'dart:async';

import 'package:app/features/profil/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/blocs/mieux_vous_connaitre_event.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/blocs/mieux_vous_connaitre_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitreBloc
    extends Bloc<MieuxVousConnaitreEvent, MieuxVousConnaitreState> {
  MieuxVousConnaitreBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  })  : _mieuxVousConnaitrePort = mieuxVousConnaitrePort,
        super(const MieuxVousConnaitreState.empty()) {
    on<MieuxVousConnaitreRecuperationDemandee>(_onRecuperationDemandee);
    on<MieuxVousConnaitreThematiqueSelectionnee>(_onThematiqueSelectionnee);
  }

  final MieuxVousConnaitrePort _mieuxVousConnaitrePort;

  Future<void> _onRecuperationDemandee(
    final MieuxVousConnaitreRecuperationDemandee event,
    final Emitter<MieuxVousConnaitreState> emit,
  ) async {
    emit(state.copyWith(statut: MieuxVousConnaitreStatut.chargement));
    final questions =
        await _mieuxVousConnaitrePort.recupererLesQuestionsDejaRepondue();
    emit(
      state.copyWith(
        questions: questions,
        questionsParCategorie: questions,
        statut: MieuxVousConnaitreStatut.succes,
      ),
    );
  }

  void _onThematiqueSelectionnee(
    final MieuxVousConnaitreThematiqueSelectionnee event,
    final Emitter<MieuxVousConnaitreState> emit,
  ) {
    emit(
      state.copyWith(
        questionsParCategorie: state.questions
            .where((final e) => e.thematique == event.valeur)
            .toList(),
        thematiqueSelectionnee: Option.of(event.valeur),
      ),
    );
  }
}
