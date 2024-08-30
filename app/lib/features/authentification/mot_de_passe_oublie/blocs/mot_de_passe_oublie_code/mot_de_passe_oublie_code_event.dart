import 'package:equatable/equatable.dart';

sealed class MotDePasseOublieCodeEvent extends Equatable {
  const MotDePasseOublieCodeEvent();

  @override
  List<Object> get props => [];
}

final class MotDePasseOublieCodeCodeChange extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeCodeChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MotDePasseOublieCodeRenvoyerCodeDemande
    extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeRenvoyerCodeDemande();
}

final class MotDePasseOublieCodeMotDePasseChange
    extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeMotDePasseChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MotDePasseOublieCodeValidationDemande
    extends MotDePasseOublieCodeEvent {
  const MotDePasseOublieCodeValidationDemande();
}
