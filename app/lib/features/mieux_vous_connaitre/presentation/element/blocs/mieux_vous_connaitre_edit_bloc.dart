import 'dart:async';

import 'package:app/features/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitreEditBloc
    extends Bloc<MieuxVousConnaitreEditEvent, MieuxVousConnaitreEditState> {
  MieuxVousConnaitreEditBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  })  : _mieuxVousConnaitrePort = mieuxVousConnaitrePort,
        super(const MieuxVousConnaitreEditState.empty()) {
    on<MieuxVousConnaitreEditRecuperationDemandee>(_onRecuperationDemandeee);
    on<MieuxVousConnaitreEditReponsesChangee>(_onReponsesChangee);
    on<MieuxVousConnaitreEditMisAJourDemandee>(_onMisAJourDemandee);
  }

  final MieuxVousConnaitrePort _mieuxVousConnaitrePort;

  Future<void> _onRecuperationDemandeee(
    final MieuxVousConnaitreEditRecuperationDemandee event,
    final Emitter<MieuxVousConnaitreEditState> emit,
  ) async {
    final result =
        await _mieuxVousConnaitrePort.recupererQuestion(id: event.id);
    if (result.isRight()) {
      final question = result.getRight().getOrElse(() => throw Exception());
      emit(state.copyWith(question: question));
    }
  }

  void _onReponsesChangee(
    final MieuxVousConnaitreEditReponsesChangee event,
    final Emitter<MieuxVousConnaitreEditState> emit,
  ) {
    emit(state.copyWith(valeur: event.valeur));
  }

  Future<void> _onMisAJourDemandee(
    final MieuxVousConnaitreEditMisAJourDemandee event,
    final Emitter<MieuxVousConnaitreEditState> emit,
  ) async {
    await _mieuxVousConnaitrePort.mettreAJour(
      id: event.id,
      reponses: state.valeur,
    );
    emit(state.copyWith(estMiseAJour: true));
  }
}
