import 'dart:async';

import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamificationBlocFake implements GamificationBloc {
  const GamificationBlocFake();

  @override
  void add(final GamificationEvent event) {}

  @override
  void addError(final Object error, [final StackTrace? stackTrace]) {}

  @override
  Future<void> close() async {}

  @override
  void emit(final GamificationState state) {}

  @override
  bool get isClosed => throw UnimplementedError();

  @override
  void on<E extends GamificationEvent>(
    final EventHandler<E, GamificationState> handler, {
    final EventTransformer<E>? transformer,
  }) {}

  @override
  void onChange(final Change<GamificationState> change) {}

  @override
  void onError(final Object error, final StackTrace stackTrace) {}

  @override
  void onEvent(final GamificationEvent event) {}

  @override
  void onTransition(
    final Transition<GamificationEvent, GamificationState> transition,
  ) {}

  @override
  GamificationState get state =>
      const GamificationState(statut: GamificationStatut.succes, points: 39);

  @override
  Stream<GamificationState> get stream => Stream.value(state);
}
