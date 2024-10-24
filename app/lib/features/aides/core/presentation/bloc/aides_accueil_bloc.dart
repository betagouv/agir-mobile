import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:app/features/aides/core/presentation/bloc/aides_accueil_event.dart';
import 'package:app/features/aides/core/presentation/bloc/aides_accueil_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AidesAccueilBloc extends Bloc<AidesAccueilEvent, AidesAccueilState> {
  AidesAccueilBloc({required final AidesPort aidesPort})
      : super(const AidesAccueilState([])) {
    on<AidesAccueilRecuperationDemandee>((final event, final emit) async {
      final result = await aidesPort.fetchAides();
      if (result.isRight()) {
        final aides = result.getRight().getOrElse(() => throw Exception());
        emit(AidesAccueilState(aides.aids.take(2).toList()));
      }
    });
  }
}
