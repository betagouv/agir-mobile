import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class MotDePasseOublieCodeEvent extends Equatable {
  const MotDePasseOublieCodeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MotDePasseOublieCodeCodeChange extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeCodeChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MotDePasseOublieCodeRenvoyerCodeDemande extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeRenvoyerCodeDemande();
}

@immutable
final class MotDePasseOublieCodeMotDePasseChange extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeMotDePasseChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MotDePasseOublieCodeValidationDemande extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeValidationDemande();
}
