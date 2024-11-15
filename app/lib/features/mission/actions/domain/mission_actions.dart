import 'package:app/features/mission/actions/domain/mission_action.dart';
import 'package:equatable/equatable.dart';

final class MissionActions extends Equatable {
  const MissionActions({
    required this.values,
    required this.canBeCompleted,
    required this.isCompleted,
  });

  final List<MissionAction> values;
  final bool canBeCompleted;
  final bool isCompleted;

  @override
  List<Object> get props => [values, canBeCompleted, isCompleted];
}
