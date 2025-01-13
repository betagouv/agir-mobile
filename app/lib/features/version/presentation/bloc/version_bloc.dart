import 'package:app/features/version/domain/version_port.dart';
import 'package:app/features/version/presentation/bloc/version_event.dart';
import 'package:app/features/version/presentation/bloc/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc({required final VersionPort versionPort})
      : super(const VersionState('')) {
    on<VersionFetched>((final event, final emit) {
      final newState = versionPort.current().fold(
            (final exception) => const VersionState(''),
            VersionState.new,
          );

      emit(newState);
    });
  }
}
