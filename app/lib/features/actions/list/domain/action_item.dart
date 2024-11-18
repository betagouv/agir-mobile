import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:equatable/equatable.dart';

final class ActionItem extends Equatable {
  const ActionItem({required this.id, required this.titre});

  final ActionId id;
  final String titre;

  @override
  List<Object?> get props => [id, titre];
}
