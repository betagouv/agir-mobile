import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:equatable/equatable.dart';

final class ActionItem extends Equatable {
  const ActionItem({
    required this.id,
    required this.titre,
    required this.status,
  });

  final ActionId id;
  final String titre;
  final ActionStatus status;

  @override
  List<Object?> get props => [id, titre, status];
}
