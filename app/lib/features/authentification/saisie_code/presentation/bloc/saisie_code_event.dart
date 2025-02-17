import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class SaisieCodeEvent extends Equatable {
  const SaisieCodeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class SaisieCodeCodeSaisie extends SaisieCodeEvent {
  const SaisieCodeCodeSaisie(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

@immutable
final class SaiseCodeRenvoyerCodeDemandee extends SaisieCodeEvent {
  const SaiseCodeRenvoyerCodeDemandee();
}
