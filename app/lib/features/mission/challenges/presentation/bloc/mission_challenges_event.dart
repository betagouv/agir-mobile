import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MissionChallengesEvent extends Equatable {
  const MissionChallengesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MissionChallengesRefreshRequested extends MissionChallengesEvent {
  const MissionChallengesRefreshRequested(this.code);

  final MissionCode code;

  @override
  List<Object> get props => [code];
}
