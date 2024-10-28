import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/presentation/bloc/univers_event.dart';
import 'package:app/features/theme/presentation/bloc/univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversBloc extends Bloc<UniversEvent, UniversState> {
  UniversBloc({required final ThemePort themePort})
      : super(
          const UniversState(themeTile: null, missions: [], services: []),
        ) {
    on<UniversRecuperationDemandee>((final event, final emit) async {
      final type = event.universType;
      (await themePort.getTheme(type)).fold(
        (final l) {},
        (final r) => emit(state.copyWith(themeTile: r)),
      );
      (await themePort.recupererMissions(type)).fold(
        (final l) {},
        (final r) => emit(state.copyWith(missions: r)),
      );
      (await themePort.getServices(type)).fold(
        (final l) {},
        (final r) => emit(state.copyWith(services: r)),
      );
    });
  }
}
