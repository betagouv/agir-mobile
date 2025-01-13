import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ChangerMotDePasseEvent extends Equatable {
  const ChangerMotDePasseEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ChangerMotDePasseAChange extends ChangerMotDePasseEvent {
  const ChangerMotDePasseAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class ChangerMotDePasseChangementDemande extends ChangerMotDePasseEvent {
  const ChangerMotDePasseChangementDemande();
}
