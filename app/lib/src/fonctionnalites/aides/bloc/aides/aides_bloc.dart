import 'dart:async';

import 'package:app/src/fonctionnalites/aides/bloc/aides/aides_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides/aides_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidesBloc extends Bloc<AidesEvent, AidesState> {
  AidesBloc({
    required final AidesRepository aidesRepository,
  })  : _aidesRepository = aidesRepository,
        super(const AidesState(aides: [])) {
    on<AidesRecuperationDemandee>(_onRecuperationDemandee);
  }

  final AidesRepository _aidesRepository;

  Future<void> _onRecuperationDemandee(
    final AidesRecuperationDemandee event,
    final Emitter<AidesState> emit,
  ) async {
    final aides = await _aidesRepository.recupereLesAides();
    final thematiques = aides.map((final e) => e.thematique).toSet();
    final aidesModel = <AidesModel>[];
    for (final thematique in thematiques) {
      aidesModel.add(AideThematiqueModel(thematique));
      aides
          .where((final e) => e.thematique == thematique)
          .forEach((final e) => aidesModel.add(AideTitreModel(e.titre)));
    }
    emit(AidesState(aides: aidesModel));
  }
}
