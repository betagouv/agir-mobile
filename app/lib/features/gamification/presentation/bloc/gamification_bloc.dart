import 'dart:async';

import 'package:app/features/authentification/core/domain/authentification_statut.dart';
import 'package:app/features/authentification/core/domain/authentification_statut_manager.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamificationBloc extends Bloc<GamificationEvent, GamificationState> {
  GamificationBloc({
    required final GamificationPort gamificationPort,
    required final AuthentificationStatutManagerReader
        authentificationStatutManagerReader,
  }) : super(const GamificationState.empty()) {
    on<GamificationAuthentificationAChange>(
      (final event, final emit) async =>
          gamificationPort.mettreAJourLesPoints(),
    );
    on<GamificationAbonnementDemande>((final event, final emit) async {
      emit(state.copyWith(statut: GamificationStatut.chargement));

      await emit.forEach<Gamification>(
        gamificationPort.gamification(),
        onData: (final data) => state.copyWith(
          statut: GamificationStatut.succes,
          points: data.points,
        ),
        onError: (final _, final __) =>
            state.copyWith(statut: GamificationStatut.erreur),
      );
    });
    _subscription = authentificationStatutManagerReader.statut.listen(
      (final statut) => add(GamificationAuthentificationAChange(statut)),
    );
  }

  late final StreamSubscription<AuthentificationStatut> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}
