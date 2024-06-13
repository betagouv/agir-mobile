import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/presentation/blocs/aide/aide_event.dart';
import 'package:app/features/aides/presentation/blocs/aide/aide_state.dart';
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
