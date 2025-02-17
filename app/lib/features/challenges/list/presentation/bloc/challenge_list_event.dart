import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ChallengeListEvent extends Equatable {
  const ChallengeListEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ChallengeListFetch extends ChallengeListEvent {
  const ChallengeListFetch();
}
