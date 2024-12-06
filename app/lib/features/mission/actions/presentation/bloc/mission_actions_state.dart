import 'package:app/features/mission/actions/domain/mission_actions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class MissionActionsState extends Equatable {
  const MissionActionsState({required this.actions});

  final MissionActions actions;

  @override
  List<Object> get props => [actions];
}
