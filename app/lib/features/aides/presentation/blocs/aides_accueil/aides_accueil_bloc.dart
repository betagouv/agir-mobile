import 'dart:async';

import 'package:app/features/aides/domain/ports/aides_port.dart';
import 'package:app/features/aides/presentation/blocs/aides_accueil/aides_accueil_event.dart';
import 'package:app/features/aides/presentation/blocs/aides_accueil/aides_accueil_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidesAccueilBloc extends Bloc<AidesAccueilEvent, AidesAccueilState> {
  AidesAccueilBloc({required final AidesPort aidesPort})
      : _aidesPort = aidesPort,
        super(const AidesAccueilState([])) {
    on<AidesAccueilRecuperationDemandee>(_onRecuperationDemandee);
  }

  final AidesPort _aidesPort;

  Future<void> _onRecuperationDemandee(
    final AidesAccueilRecuperationDemandee event,
    final Emitter<AidesAccueilState> emit,
  ) async {
    final aides = await _aidesPort.recupereLesAides();
    emit(AidesAccueilState(aides.take(2).toList()));
  }
}
