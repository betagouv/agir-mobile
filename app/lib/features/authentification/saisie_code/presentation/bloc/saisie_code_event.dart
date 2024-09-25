import 'package:equatable/equatable.dart';

sealed class SaisieCodeEvent extends Equatable {
  const SaisieCodeEvent();

  @override
  List<Object> get props => [];
}

final class SaisieCodeCodeSaisie extends SaisieCodeEvent {
  const SaisieCodeCodeSaisie(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class SaiseCodeRenvoyerCodeDemandee extends SaisieCodeEvent {
  const SaiseCodeRenvoyerCodeDemandee();
}
