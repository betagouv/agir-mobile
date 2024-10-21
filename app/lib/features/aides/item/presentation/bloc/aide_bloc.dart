import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_event.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AideBloc extends Bloc<AideEvent, AideState> {
  AideBloc()
      : super(const AideState(Aid(titre: '', thematique: '', contenu: ''))) {
    on<AideSelectionnee>(
      (final event, final emit) => emit(AideState(event.value)),
    );
  }
}
