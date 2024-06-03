import 'package:app/src/fonctionnalites/version/bloc/version_event.dart';
import 'package:app/src/fonctionnalites/version/bloc/version_state.dart';
import 'package:app/src/fonctionnalites/version/domain/ports/version_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc({required final VersionRepository versionRepository})
      : _versionRepository = versionRepository,
        super(const VersionState('')) {
    on<VersionDemandee>(_onDemandee);
  }

  final VersionRepository _versionRepository;

  void _onDemandee(
    final VersionDemandee event,
    final Emitter<VersionState> emit,
  ) =>
      emit(VersionState(_versionRepository.versionDemandee()));
}
