import 'dart:async';

import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_state.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCodePostalBloc
    extends Bloc<QuestionCodePostalEvent, QuestionCodePostalState> {
  QuestionCodePostalBloc({required final ProfilPort profilPort})
      : _profilPort = profilPort,
        super(
          const QuestionCodePostalState(codePostal: '', aEteChange: false),
        ) {
    on<QuestionCodePostalAChange>(_onAChange);
    on<QuestionCodePostalMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final ProfilPort _profilPort;

  void _onAChange(
    final QuestionCodePostalAChange event,
    final Emitter<QuestionCodePostalState> emit,
  ) {
    emit(state.copyWith(codePostal: event.valeur));
  }

  Future<void> _onMiseAJourDemandee(
    final QuestionCodePostalMiseAJourDemandee event,
    final Emitter<QuestionCodePostalState> emit,
  ) async {
    await _profilPort.mettreAJourCodePostal(state.codePostal);

    emit(state.copyWith(aEteChange: true));
  }
}
