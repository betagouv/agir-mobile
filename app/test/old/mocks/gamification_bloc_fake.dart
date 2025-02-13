import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_state.dart';
import 'package:flutter_test/flutter_test.dart';

class GamificationBlocFake extends Fake implements GamificationBloc {
  @override
  GamificationState get state => const GamificationState(statut: GamificationStatut.succes, points: 39);

  @override
  Stream<GamificationState> get stream => Stream.value(state);

  @override
  Future<void> close() async {}
}
