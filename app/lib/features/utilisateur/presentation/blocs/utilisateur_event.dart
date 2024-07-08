import 'package:equatable/equatable.dart';

sealed class UtilisateurEvent extends Equatable {
  const UtilisateurEvent();

  @override
  List<Object> get props => [];
}

final class UtilisateurRecuperationDemandee extends UtilisateurEvent {
  const UtilisateurRecuperationDemandee();
}
