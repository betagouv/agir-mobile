import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_event.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_state.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AidesAccueilBloc extends Bloc<AidesAccueilEvent, AidesAccueilState> {
  AidesAccueilBloc({required final AssistancesRepository aidesPort})
      : super(const AidesAccueilState([])) {
    on<AidesAccueilRecuperationDemandee>((final event, final emit) async {
      final result = await aidesPort.fetch();
      if (result.isRight()) {
        final aides = result.getRight().getOrElse(() => throw Exception());
        emit(AidesAccueilState(aides.assistances.take(2).toList()));
      }
    });
  }
}
