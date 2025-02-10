import 'package:app/features/aids/core/presentation/bloc/aids_home_event.dart';
import 'package:app/features/aids/core/presentation/bloc/aids_home_state.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidsHomeBloc extends Bloc<AidsHomeEvent, AidsHomeState> {
  AidsHomeBloc({required final AidsRepository aidsRepository})
      : super(const AidsHomeState([])) {
    on<AidsHomeLoadRequested>((final event, final emit) async {
      final result = await aidsRepository.fetch();
      result.fold(
        (final l) {},
        (final r) => emit(AidsHomeState(r.aids.take(2).toList())),
      );
    });
  }
}
