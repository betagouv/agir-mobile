import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/presentation/blocs/univers_event.dart';
import 'package:app/features/univers/presentation/blocs/univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversBloc extends Bloc<UniversEvent, UniversState> {
  UniversBloc({
    required final TuileUnivers univers,
    required final UniversPort universPort,
  }) : super(UniversState(univers: univers, thematiques: const [])) {
    on<UniversThematiquesRecuperationDemandee>(
      (final event, final emit) async {
        final result = await universPort.recupererThematiques(
          universType: event.universType,
        );
        result.fold(
          (final exception) {},
          (final thematiques) => emit(state.copyWith(thematiques: thematiques)),
        );
      },
    );
  }
}
