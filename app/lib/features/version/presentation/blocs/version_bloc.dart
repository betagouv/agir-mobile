import 'package:app/features/version/domain/ports/version_port.dart';
import 'package:app/features/version/presentation/blocs/version_event.dart';
import 'package:app/features/version/presentation/blocs/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc({required final VersionPort versionPort})
      : _versionPort = versionPort,
        super(const VersionState('')) {
    on<VersionDemandee>(_onDemandee);
  }

  final VersionPort _versionPort;

  void _onDemandee(
    final VersionDemandee event,
    final Emitter<VersionState> emit,
  ) {
    final result = _versionPort.versionDemandee();
    if (result.isRight()) {
      final version = result.getRight().getOrElse(() => throw Exception());
      emit(VersionState(version));
    }
  }
}
