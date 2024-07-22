import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/presentation/blocs/univers_event.dart';
import 'package:app/features/univers/presentation/blocs/univers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversBloc extends Bloc<UniversEvent, UniversState> {
  UniversBloc({required final TuileUnivers univers})
      : super(UniversState(univers: univers)) {
    on<UniversEvent>((final event, final emit) {});
  }
}
