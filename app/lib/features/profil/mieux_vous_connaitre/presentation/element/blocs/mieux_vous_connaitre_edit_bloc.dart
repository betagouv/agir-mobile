import 'dart:async';

import 'package:app/features/profil/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MieuxVousConnaitreEditBloc
    extends Bloc<MieuxVousConnaitreEditEvent, MieuxVousConnaitreEditState> {
  MieuxVousConnaitreEditBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  })  : _mieuxVousConnaitrePort = mieuxVousConnaitrePort,
        super(const MieuxVousConnaitreEditState.empty()) {
    on<MieuxVousConnaitreEditReponsesChangee>(_onReponseLibreChangee);
    on<MieuxVousConnaitreEditMisAJourDemandee>(_onMisAJourDemandee);
  }

  final MieuxVousConnaitrePort _mieuxVousConnaitrePort;

  void _onReponseLibreChangee(
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
