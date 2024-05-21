import 'package:agir/authentification/redux/utilisateur_state.dart';
import 'package:agir/interactions/redux/interactions_state.dart';
import 'package:equatable/equatable.dart';

class AgirState extends Equatable {
  final UtilisateurState utilisateurState;
  final InteractionsState interactionsState;

  const AgirState(this.utilisateurState, this.interactionsState);

  @override
  List<Object?> get props => [utilisateurState, interactionsState];
}