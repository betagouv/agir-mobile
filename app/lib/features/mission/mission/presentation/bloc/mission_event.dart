import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:equatable/equatable.dart';

sealed class MissionEvent extends Equatable {
  const MissionEvent();

  @override
  List<Object> get props => [];
}

final class MissionLoadRequested extends MissionEvent {
  const MissionLoadRequested(this.code);

  final MissionCode code;

  @override
  List<Object> get props => [code];
}

final class MissionPreviousRequested extends MissionEvent {
  const MissionPreviousRequested();
}

final class MissionNextRequested extends MissionEvent {
  const MissionNextRequested();
}

final class MissionCompleteRequested extends MissionEvent {
  const MissionCompleteRequested();
}
