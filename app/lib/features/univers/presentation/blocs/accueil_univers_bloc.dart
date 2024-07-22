import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/presentation/blocs/accueil_univers_event.dart';
import 'package:app/features/univers/presentation/blocs/accueil_univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AccueilUniversBloc
    extends Bloc<AccueilUniversEvent, AccueilUniversState> {
  AccueilUniversBloc({required final UniversPort universPort})
      : _universPort = universPort,
        super(const AccueilUniversState.empty()) {
    on<AccueilUniversRecuperationDemandee>(_onRecuperationDemandee);
  }

  final UniversPort _universPort;

  Future<void> _onRecuperationDemandee(
    final AccueilUniversRecuperationDemandee event,
    final Emitter<AccueilUniversState> emit,
  ) async {
    final result = await _universPort.recuperer();
    if (result.isRight()) {
      final univers = result.getRight().getOrElse(() => throw Exception());

      emit(AccueilUniversState(univers: univers));
    }
  }
}
