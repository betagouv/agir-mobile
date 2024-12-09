import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required final ThemePort themePort})
      : super(
          const ThemeState(
            themeType: ThemeType.alimentation,
            missions: [],
            services: [],
          ),
        ) {
    on<ThemeRecuperationDemandee>((final event, final emit) async {
      final type = event.themeType;
      final missionsResult = await themePort.recupererMissions(type);
      final servicesResult = await themePort.getServices(type);
      missionsResult.fold(
        (final l) {},
        (final missions) => servicesResult.fold(
          (final l) {},
          (final services) => emit(
            state.copyWith(
              themeType: switch (type) {
                'alimentation' => ThemeType.alimentation,
                'transport' => ThemeType.transport,
                'consommation' => ThemeType.consommation,
                'logement' => ThemeType.logement,
                _ => ThemeType.decouverte,
              },
              missions: missions,
              services: services,
            ),
          ),
        ),
      );
    });
  }
}
