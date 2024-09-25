import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:app/features/univers/presentation/bloc/univers_event.dart';
import 'package:app/features/univers/presentation/bloc/univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversBloc extends Bloc<UniversEvent, UniversState> {
  UniversBloc({
    required final TuileUnivers univers,
    required final UniversPort universPort,
  }) : super(
          UniversState(
            univers: univers,
            thematiques: const [],
            services: const [],
          ),
        ) {
    on<UniversRecuperationDemandee>((final event, final emit) async {
      final universType = event.universType;
      final thematiqueResult =
          await universPort.recupererThematiques(universType);
      final serviceResult = await universPort.getServices(universType);

      thematiqueResult.fold(
        (final l) {},
        (final r) => emit(state.copyWith(thematiques: r)),
      );
      serviceResult.fold(
        (final l) {},
        (final r) => emit(state.copyWith(services: r)),
      );
    });
  }
}
