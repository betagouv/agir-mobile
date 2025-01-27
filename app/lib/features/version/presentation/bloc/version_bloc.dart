import 'package:app/features/version/infrastructure/version_repository.dart';
import 'package:app/features/version/presentation/bloc/version_event.dart';
import 'package:app/features/version/presentation/bloc/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc({required final VersionRepository repository})
      : super(const VersionState('')) {
    on<VersionFetched>(
      (final event, final emit) => emit(VersionState(repository.current())),
    );
  }
}
