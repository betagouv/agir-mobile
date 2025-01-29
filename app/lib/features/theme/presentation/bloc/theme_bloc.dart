import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required final ThemeRepository themeApiAdapter})
      : super(
          const ThemeState(
            themeType: ThemeType.alimentation,
            missions: [],
            services: [],
          ),
        ) {
    on<ThemeRecuperationDemandee>((final event, final emit) async {
      final themeType = event.themeType;
      final missionsResult = await themeApiAdapter.getMissions(themeType);
      final servicesResult = await themeApiAdapter.getServices(themeType);
      missionsResult.fold(
        (final l) {},
        (final missions) => servicesResult.fold(
          (final l) {},
          (final services) => emit(
            state.copyWith(
              themeType: themeType,
              missions: missions,
              services: services,
            ),
          ),
        ),
      );
    });
  }
}
