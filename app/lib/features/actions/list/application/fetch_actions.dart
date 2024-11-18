import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:fpdart/fpdart.dart';

class FetchActions {
  const FetchActions(this._port);

  final ActionsPort _port;

  Future<Either<Exception, List<ActionItem>>> call() async =>
      _port.fetchActions();
}
