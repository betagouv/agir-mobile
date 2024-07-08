import 'dart:async';

import 'package:app/features/aides/domain/ports/aides_port.dart';
import 'package:app/features/aides/presentation/blocs/aides/aides_event.dart';
import 'package:app/features/aides/presentation/blocs/aides/aides_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AidesBloc extends Bloc<AidesEvent, AidesState> {
  AidesBloc({required final AidesPort aidesPort})
      : _aidesPort = aidesPort,
        super(const AidesState(aides: [])) {
    on<AidesRecuperationDemandee>(_onRecuperationDemandee);
  }

  final AidesPort _aidesPort;

  Future<void> _onRecuperationDemandee(
    final AidesRecuperationDemandee event,
    final Emitter<AidesState> emit,
  ) async {
    final result = await _aidesPort.recupereLesAides();
    if (result.isRight()) {
      final aides = result.getRight().getOrElse(() => throw Exception());
      final thematiques = aides.map((final e) => e.thematique).toSet();
      final aidesModel = <AidesModel>[];
      for (final thematique in thematiques) {
        aidesModel.add(AideThematiqueModel(thematique));
        aides
            .where((final e) => e.thematique == thematique)
            .forEach((final e) => aidesModel.add(AideModel(e)));
      }
      emit(AidesState(aides: aidesModel));
    }
  }
}
