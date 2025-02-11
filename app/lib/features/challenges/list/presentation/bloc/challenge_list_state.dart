import 'package:app/features/challenges/list/domain/challenge_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ChallengeListState extends Equatable {
  const ChallengeListState();

  @override
  List<Object> get props => [];
}

@immutable
final class ChallengeListInitial extends ChallengeListState {
  const ChallengeListInitial();
}

@immutable
final class ChallengeListLoading extends ChallengeListState {
  const ChallengeListLoading();
}

@immutable
final class ChallengeListSuccess extends ChallengeListState {
  const ChallengeListSuccess({required this.challenges});

  final List<ChallengeItem> challenges;

  @override
  List<Object> get props => [challenges];
}

@immutable
final class ChallengeListFailure extends ChallengeListState {
  const ChallengeListFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
