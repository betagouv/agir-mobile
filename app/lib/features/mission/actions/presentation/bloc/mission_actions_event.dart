import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class MissionActionsEvent extends Equatable {
  const MissionActionsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MissionActionRefreshRequested extends MissionActionsEvent {
  const MissionActionRefreshRequested(this.code);

  final MissionCode code;

  @override
  List<Object> get props => [code];
}
