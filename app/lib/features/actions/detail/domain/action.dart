import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:equatable/equatable.dart';

class Action extends Equatable {
  const Action({
    required this.id,
    required this.theme,
    required this.title,
    required this.status,
    required this.reason,
    required this.tips,
    required this.why,
  });

  final ActionId id;
  final String theme;
  final String title;
  final ActionStatus status;
  final String? reason;
  final String tips;
  final String why;

  @override
  List<Object?> get props => [id, theme, title, status, reason, tips, why];
}
