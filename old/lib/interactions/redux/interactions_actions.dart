import 'package:agir/interactions/fetchInteractions_usecase.dart';

class LoadInteractionsActions {
  final String utilisateurId;
  LoadInteractionsActions(this.utilisateurId);
}

class HandleLoadInteractionsResultActions {
  final List<Interaction> interactions;
  HandleLoadInteractionsResultActions(this.interactions);
}