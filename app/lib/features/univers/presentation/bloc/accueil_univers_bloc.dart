import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:app/features/univers/presentation/bloc/accueil_univers_event.dart';
import 'package:app/features/univers/presentation/bloc/accueil_univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AccueilUniversBloc
    extends Bloc<AccueilUniversEvent, AccueilUniversState> {
  AccueilUniversBloc({required final UniversPort universPort})
      : super(const AccueilUniversState.empty()) {
    on<AccueilUniversRecuperationDemandee>((final event, final emit) async {
      final result = await universPort.recuperer();
      if (result.isRight()) {
        final univers = result.getRight().getOrElse(() => throw Exception());

        emit(AccueilUniversState(univers: univers));
      }
    });
  }
}
