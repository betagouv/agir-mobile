import 'dart:async';

import 'package:app/src/fonctionnalites/aides/bloc/aides_accueil/aides_accueil_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_accueil/aides_accueil_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidesAccueilBloc extends Bloc<AidesAccueilEvent, AidesAccueilState> {
  AidesAccueilBloc({required final AidesRepository aidesRepository})
      : _aidesRepository = aidesRepository,
        super(const AidesAccueilState([])) {
    on<AidesAccueilRecuperationDemandee>(_onRecuperationDemandee);
  }

  final AidesRepository _aidesRepository;

  Future<void> _onRecuperationDemandee(
    final AidesAccueilRecuperationDemandee event,
    final Emitter<AidesAccueilState> emit,
  ) async {
    final aides = await _aidesRepository.recupereLesAides();
    emit(AidesAccueilState(aides.take(2).toList()));
  }
}
