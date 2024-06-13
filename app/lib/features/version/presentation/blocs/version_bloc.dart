import 'package:app/features/version/domain/ports/version_port.dart';
import 'package:app/features/version/presentation/blocs/version_event.dart';
import 'package:app/features/version/presentation/blocs/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc({required final VersionPort versionRepository})
      : _versionRepository = versionRepository,
        super(const VersionState('')) {
    on<VersionDemandee>(_onDemandee);
  }

  final VersionPort _versionRepository;

  void _onDemandee(
    final VersionDemandee event,
    final Emitter<VersionState> emit,
  ) =>
      emit(VersionState(_versionRepository.versionDemandee()));
}
