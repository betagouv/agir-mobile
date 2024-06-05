import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AideBloc extends Bloc<AideEvent, AideState> {
  AideBloc()
      : super(const AideState(Aide(titre: '', thematique: '', contenu: ''))) {
    on<AideSelectionnee>(_onSelectionnee);
  }

  void _onSelectionnee(
    final AideSelectionnee event,
    final Emitter<AideState> emit,
  ) {
    emit(AideState(event.value));
  }
}
