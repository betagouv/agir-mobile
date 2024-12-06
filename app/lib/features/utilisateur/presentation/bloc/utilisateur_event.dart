import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class UtilisateurEvent extends Equatable {
  const UtilisateurEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class UtilisateurRecuperationDemandee extends UtilisateurEvent {
  const UtilisateurRecuperationDemandee();
}
