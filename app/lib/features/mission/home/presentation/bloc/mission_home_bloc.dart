import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_event.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionHomeBloc extends Bloc<MissionHomeEvent, MissionHomeState> {
  MissionHomeBloc({required final MissionHomeRepository repository})
      : super(const MissionHomeInitial()) {
    on<MissionHomeFetch>((final event, final emit) async {
      final result = await repository.fetch();
      result.fold(
        (final l) => emit(const MissionHomeInitial()),
        (final r) => emit(MissionHomeLoadSuccess(r)),
      );
    });
  }
}
