import 'dart:async';
import 'package:app/src/fonctionnalites/aides/bloc/aides_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidesBloc extends Bloc<AidesEvent, AidesState> {
  AidesBloc({
    required final AidesRepository aidesRepository,
  })  : _aidesRepository = aidesRepository,
        super(const AidesState([])) {
    on<AidesRecuperationDemandee>(_onRecuperationDemandee);
  }

  final AidesRepository _aidesRepository;

  Future<FutureOr<void>> _onRecuperationDemandee(
    final AidesRecuperationDemandee event,
    final Emitter<AidesState> emit,
  ) async {
    final aides = await _aidesRepository.recupereLesAides();
    emit(AidesState(aides.take(2).map((final e) => e.titre).toList()));
  }
}
