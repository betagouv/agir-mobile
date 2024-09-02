import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/presentation/blocs/univers_event.dart';
import 'package:app/features/univers/presentation/blocs/univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversBloc extends Bloc<UniversEvent, UniversState> {
  UniversBloc({
    required final TuileUnivers univers,
    required final UniversPort universPort,
  })  : _universPort = universPort,
        super(UniversState(univers: univers, thematiques: const [])) {
    on<UniversThematiquesRecuperationDemandee>(
      _onThematiquesRecuperationDemandee,
    );
  }

  final UniversPort _universPort;

  Future<void> _onThematiquesRecuperationDemandee(
    final UniversThematiquesRecuperationDemandee event,
    final Emitter<UniversState> emit,
  ) async {
    final result =
        await _universPort.recupererThematiques(universType: event.universType);
    result.fold(
      (final exception) {},
      (final thematiques) => emit(state.copyWith(thematiques: thematiques)),
    );
  }
}
