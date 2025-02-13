import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/list/domain/challenge_item.dart';
import 'package:app/features/challenges/list/infrastructure/challenge_list_repository.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class FetchChallenges {
  const FetchChallenges(this._repository);

  final ChallengeListRepository _repository;

  Future<Either<Exception, List<ChallengeItem>>> call() async {
    final result = await _repository.fetchChallenges();
    const order = [
      ChallengeStatus.inProgress,
      ChallengeStatus.done,
      ChallengeStatus.alreadyDone,
      ChallengeStatus.abandonned,
      ChallengeStatus.refused,
    ];

    return result.map(
      (final challenges) =>
          challenges
              .sorted(
                (final a, final b) =>
                    order.indexOf(a.status).compareTo(order.indexOf(b.status)),
              )
              .toList(),
    );
  }
}
