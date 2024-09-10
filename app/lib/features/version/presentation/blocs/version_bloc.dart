import 'package:app/features/version/domain/ports/version_port.dart';
import 'package:app/features/version/presentation/blocs/version_event.dart';
import 'package:app/features/version/presentation/blocs/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc({required final VersionPort versionPort})
      : super(const VersionState('')) {
    on<VersionDemandee>((final event, final emit) {
      final result = versionPort.versionDemandee();
      if (result.isRight()) {
        final version = result.getRight().getOrElse(() => throw Exception());
        emit(VersionState(version));
      }
    });
  }
}
