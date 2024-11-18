import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/list/domain/action_item.dart';

abstract final class ActionItemMapper {
  const ActionItemMapper._();

  static ActionItem fromJson(final Map<String, dynamic> json) => ActionItem(
        id: ActionId(json['id'] as String),
        titre: json['titre'] as String,
      );
}
