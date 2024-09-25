import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ActionsPort {
  Future<Either<Exception, List<ActionItem>>> fetchActions();
}
