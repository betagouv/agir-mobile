import 'dart:async';

import 'package:app/features/recommandations/domain/ports/recommandations_port.dart';
import 'package:app/features/recommandations/presentation/blocs/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/blocs/recommandations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsBloc
    extends Bloc<RecommandationsEvent, RecommandationsState> {
  RecommandationsBloc({required final RecommandationsPort recommandationsPort})
      : _recommandationsPort = recommandationsPort,
        super(const RecommandationsState.empty()) {
    on<RecommandationsRecuperationDemandee>(_onRecuperationDemandee);
  }

  final RecommandationsPort _recommandationsPort;

  Future<void> _onRecuperationDemandee(
    final RecommandationsRecuperationDemandee event,
    final Emitter<RecommandationsState> emit,
  ) async {
    final result = await _recommandationsPort.recuperer();
    if (result.isRight()) {
      final recommandations =
          result.getRight().getOrElse(() => throw Exception());

      emit(RecommandationsState(recommandations: recommandations));
    }
  }
}
