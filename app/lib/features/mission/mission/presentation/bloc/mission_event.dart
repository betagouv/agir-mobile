import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MissionEvent extends Equatable {
  const MissionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MissionLoadRequested extends MissionEvent {
  const MissionLoadRequested(this.code);

  final MissionCode code;

  @override
  List<Object> get props => [code];
}

@immutable
final class MissionPreviousRequested extends MissionEvent {
  const MissionPreviousRequested();
}

@immutable
final class MissionNextRequested extends MissionEvent {
  const MissionNextRequested();
}

@immutable
final class MissionCompleteRequested extends MissionEvent {
  const MissionCompleteRequested();
}
