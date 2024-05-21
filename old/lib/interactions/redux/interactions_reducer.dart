import 'package:agir/agir_state.dart';
import 'package:agir/interactions/redux/interactions_state.dart';
import 'package:redux/redux.dart';

import 'interactions_actions.dart';


List<Reducer<AgirState>> createInteractionsReducers() {
  return [TypedReducer<AgirState,HandleLoadInteractionsResultActions>(_onHandleInteractionsResultAction).call];
}

AgirState _onHandleInteractionsResultAction(AgirState state, HandleLoadInteractionsResultActions action)  {
  return AgirState(state.utilisateurState, InteractionsState(action.interactions));
}