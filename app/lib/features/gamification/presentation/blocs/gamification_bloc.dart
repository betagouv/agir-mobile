import 'dart:async';

import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/domain/ports/gamification_port.dart';
import 'package:app/features/gamification/presentation/blocs/gamification_event.dart';
import 'package:app/features/gamification/presentation/blocs/gamification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamificationBloc extends Bloc<GamificationEvent, GamificationState> {
  GamificationBloc({
    required final GamificationPort gamificationPort,
    required final AuthentificationStatutManagerReader
        authentificationStatutManagerReader,
  })  : _gamificationPort = gamificationPort,
        _authentificationStatutManagerReader =
            authentificationStatutManagerReader,
        super(const GamificationState.empty()) {
    on<GamificationAuthentificationAChange>(_onAuthentificationAChange);
    on<GamificationAbonnementDemande>(_onAbonnementDemande);
    _subscription = _authentificationStatutManagerReader.statut.listen(
      (final statut) => add(GamificationAuthentificationAChange(statut)),
    );
  }

  final GamificationPort _gamificationPort;
  final AuthentificationStatutManagerReader
      _authentificationStatutManagerReader;
  late final StreamSubscription<AuthentificationStatut> _subscription;

  Future<void> _onAuthentificationAChange(
    final GamificationAuthentificationAChange event,
    final Emitter<GamificationState> emit,
  ) async =>
      _gamificationPort.mettreAJourLesPoints();

  Future<void> _onAbonnementDemande(
    final GamificationAbonnementDemande event,
    final Emitter<GamificationState> emit,
  ) async {
    emit(state.copyWith(statut: GamificationStatut.chargement));

    await emit.forEach<Gamification>(
      _gamificationPort.gamification(),
      onData: (final data) => state.copyWith(
        statut: GamificationStatut.succes,
        points: data.points,
      ),
      onError: (final _, final __) =>
          state.copyWith(statut: GamificationStatut.erreur),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}
