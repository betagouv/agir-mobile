import 'package:equatable/equatable.dart';

sealed class ChangerMotDePasseEvent extends Equatable {
  const ChangerMotDePasseEvent();

  @override
  List<Object> get props => [];
}

final class ChangerMotDePasseAChange extends ChangerMotDePasseEvent {
  const ChangerMotDePasseAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class ChangerMotDePasseChangementDemande extends ChangerMotDePasseEvent {
  const ChangerMotDePasseChangementDemande();
}
