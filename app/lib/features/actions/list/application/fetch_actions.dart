import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class FetchActions {
  const FetchActions(this._port);

  final ActionsPort _port;

  Future<Either<Exception, List<ActionItem>>> call() async {
    final result = await _port.fetchActions();

    return result.map(
      (final actions) => actions.sorted((final a, final b) {
        final order = [
          ActionStatus.inProgress,
          ActionStatus.done,
          ActionStatus.alreadyDone,
          ActionStatus.abandonned,
          ActionStatus.refused,
        ];

        return order.indexOf(a.status).compareTo(order.indexOf(b.status));
      }).toList(),
    );
  }
}
