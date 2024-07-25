import 'dart:async';

import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_state.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPrenomBloc
    extends Bloc<QuestionPrenomEvent, QuestionPrenomState> {
  QuestionPrenomBloc({required final ProfilPort profilPort})
      : _profilPort = profilPort,
        super(const QuestionPrenomState(prenom: '', aEteChange: false)) {
    on<QuestionPrenomAChange>(_onAChange);
    on<QuestionPrenomMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final ProfilPort _profilPort;

  void _onAChange(
    final QuestionPrenomAChange event,
    final Emitter<QuestionPrenomState> emit,
  ) {
    emit(state.copyWith(prenom: event.valeur));
  }

  Future<void> _onMiseAJourDemandee(
    final QuestionPrenomMiseAJourDemandee event,
    final Emitter<QuestionPrenomState> emit,
  ) async {
    await _profilPort.mettreAJourPrenom(state.prenom);

    emit(state.copyWith(aEteChange: true));
  }
}
