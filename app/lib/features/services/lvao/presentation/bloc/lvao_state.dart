import 'package:app/features/services/lvao/domain/lvao_actor.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LvaoState extends Equatable {
  const LvaoState();

  @override
  List<Object> get props => [];
}

@immutable
final class LvaoInitial extends LvaoState {
  const LvaoInitial();
}

@immutable
final class LvaoLoadInProgress extends LvaoState {
  const LvaoLoadInProgress();
}

@immutable
final class LvaoLoadSuccess extends LvaoState {
  const LvaoLoadSuccess({required this.actors});

  final List<LvaoActor> actors;

  @override
  List<Object> get props => [actors];
}

@immutable
final class LvaoLoadFailure extends LvaoState {
  const LvaoLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
